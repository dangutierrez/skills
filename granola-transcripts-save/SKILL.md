---
name: granola-transcripts-save
description: "Save plain-text copies of Granola meetings to a local folder, one .txt file per meeting named by date, skipping meetings already saved. Saves the verbatim transcript on paid Granola plans, or Granola's AI summary plus your notes on the free plan. Use when the user asks to save, back up, export, download, archive, or sync their Granola transcripts, notes or meetings locally, or says things like \"save today's transcripts\" or \"back up my Granola meetings from this week\"."
---

# Save Granola meetings as plain text

Pull meetings from the Granola MCP connector and write each one to a local `.txt` file.

**Output folder:** `~/Transcripts/` by default. If the user names another folder, use it and
suggest they edit this line so it sticks. Create the folder if it's missing. Never write
meeting files inside the skill's own directory.

## Requirements and limits

- The Granola connector (`https://mcp.granola.ai`), added in Claude and signed in.
- **Verbatim transcripts need a paid Granola plan.** On the free plan `get_meeting_transcript`
  returns "Transcripts are only available to paid Granola tiers". `list_meetings` and
  `get_meetings` (AI summary, private notes, attendees) still work, so the skill falls back to
  summary mode.
- `list_meetings` only reaches back 30 days (`this_week`, `last_week`, `last_30_days`). Run the
  skill at least monthly if you want a complete archive.

Don't try to read Granola's desktop files instead. The local cache
(`~/Library/Application Support/Granola/cache-v6.json.enc`) and `granola.db` are encrypted, and
the plain `cache-v3.json` that older third-party MCP servers parsed no longer exists.

## Step 1: Check the connector and pick a mode

Run `ToolSearch` with query `granola` (max_results 10). You want the tools that list meetings,
get meeting details, and return a transcript. As of Sep 2026 these are `list_meetings`,
`get_meetings` and `get_meeting_transcript`. If names differ, use whichever tools do those jobs.

If the only Granola tools are `authenticate` / `complete_authentication`, stop and tell the user:

> Granola isn't connected in this session. Run `/mcp`, pick the Granola server, sign in, then ask again.

Then call `get_meeting_transcript` on one meeting from the list:

- It returns text → **transcript mode**.
- It returns the paid-tier error → tell the user in one line, and ask whether to save
  Granola's AI summary and their notes instead (**summary mode**). Write nothing until they answer.

## Step 2: Work out which meetings

| User says | Window |
|---|---|
| "today" | today |
| "this week" | `this_week` |
| "last week" | `last_week` |
| "last N days" (N ≤ 30) | `last_30_days`, filtered to N days |
| a meeting name or person | list, then match on title and participants; if several match, ask |
| "all", "everything" | `last_30_days` (the connector's limit) |
| nothing specific | since the newest file in the output folder; if it's empty, `this_week` |

State the window in one line before pulling ("Saving meetings from Mon Sep 21 to now").

## Step 3: Skip meetings already saved

Every saved file carries a `Granola ID:` header line, so the folder itself is the sync record:

```bash
mkdir -p ~/Transcripts
grep -h '^Granola ID:' ~/Transcripts/*.txt 2>/dev/null | awk '{print $3}'
```

Drop any meeting whose ID is already there, unless the user says "re-save", "refresh" or
"overwrite". Re-saving in transcript mode is also the way to upgrade files first saved in
summary mode.

## Step 4: Fetch and write each meeting

**Filename:** start with the date so the folder sorts chronologically:
`YYYY-MM-DD_HHMM_<slug>.txt`, using the meeting's start time in the machine's local timezone
(`readlink /etc/localtime` on macOS). Slug = title lowercased, runs of non-alphanumerics
replaced with `-`, trimmed to 60 characters. Example: `2026-09-23_1400_weekly-team-sync.txt`.
If two meetings produce the same name, append `-2`.

**Header (both modes):**

```
Title: Weekly Team Sync
Date: 2026-09-23 14:00 CDT
Attendees: Alex Rivera, Sam Lee, Priya Shah
Granola ID: <meeting id>
Granola URL: <note url>
Content: Transcript
Saved: 2026-09-24

----------------------------------------
```

Attendees come from the meeting's known participants: display name where Granola has one,
otherwise the email username. In summary mode, set `Content: Granola AI summary and private
notes (transcripts need a paid Granola plan)`.

**Transcript mode body:**

```
[00:00:12] Alex Rivera: Okay, let's start with the rollout.
[00:00:20] Sam Lee: We merged the settings page yesterday.
```

- Copy the transcript **verbatim**. Don't summarize, remove filler words, fix grammar or merge turns.
- One line per utterance: timestamp (if given), speaker, text. Merge consecutive fragments
  from the same speaker only when the connector splits mid-sentence.
- Keep speaker labels exactly as given (`Microphone`, `System audio`, `Speaker A`). Don't guess
  who a generic label is.

**Summary mode body** (from `get_meetings`, up to 10 IDs per call):

```
---------- Granola summary ----------

<summary>

---------- My notes ----------

<private notes, or "(no notes)">
```

**Both modes:** plain text only. Turn `# Heading` into the heading in capitals on its own line,
keep `- ` bullets and indentation, drop `**` bold markers, and decode HTML entities (`&apos;`,
`&amp;`). Don't reword anything.

If a meeting has nothing to save (a calendar placeholder with no recording or notes), skip it
and list it in the report rather than writing an empty file.

Work in chronological order and write each file as soon as its data arrives, so a failure
partway through keeps what's done.

### Rate limiting

Granola's connector rate-limits hard and the cooldown is long. In testing, six subagents calling
`get_meetings` in parallel hit "Rate limit exceeded. Please slow down requests." after about
seven calls, single-ID calls were still refused minutes later, and the server then returned
502s for a while. So:

- **One caller only.** Never split Granola calls across parallel subagents or parallel tool
  calls. If you delegate, give one subagent the whole list.
- **Batch and pace.** `get_meetings` takes up to 10 IDs, so use full batches. Transcripts come
  one meeting per call. Wait 20 seconds between any two Granola calls (`sleep 20` in Bash; if
  the harness blocks a foreground sleep, run it in the background and continue when it
  finishes). `list_meetings` counts too.
- **Back off on errors.** On "Rate limit exceeded" or a 5xx such as "Error 502: Bad gateway",
  wait 2 minutes, then 4, then 8 before retrying the same call. Don't retry faster, and don't
  break the batch into single IDs: every call counts against the limit.
- **Stop cleanly.** If the third backoff also fails, stop calling Granola. Keep the files
  already written and list the IDs still missing in the report. The next run picks them up,
  because Step 3 skips everything already saved.

Small, frequent runs avoid most of this. A weekly run is usually 10 to 20 meetings, which fits
in two `get_meetings` calls.

## Weekly auto-run (macOS)

`run-weekly.sh` in this folder runs the skill headlessly with `claude -p`, asking for the last
8 days (a day of overlap so evening and weekend meetings aren't missed) and a fixed tool
allowlist. If Granola is unreachable or meetings are left unsaved, it retries 30 and 60 minutes
later. Duplicate or late runs are harmless because of Step 3.

To schedule it for Fridays at 17:00 with launchd:

1. Edit the variables at the top of `run-weekly.sh` and run `chmod +x run-weekly.sh`.
2. Save this as `~/Library/LaunchAgents/local.granola-transcripts-save.plist`, with the script's
   absolute path filled in:

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
     <key>Label</key><string>local.granola-transcripts-save</string>
     <key>ProgramArguments</key>
     <array><string>/bin/zsh</string><string>-l</string><string>/ABSOLUTE/PATH/run-weekly.sh</string></array>
     <key>StartCalendarInterval</key>
     <dict>
       <key>Weekday</key><integer>5</integer>
       <key>Hour</key><integer>17</integer>
       <key>Minute</key><integer>0</integer>
     </dict>
   </dict>
   </plist>
   ```

3. Load it: `launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/local.granola-transcripts-save.plist`.
   Pause it with `launchctl bootout gui/$(id -u)/local.granola-transcripts-save`.

launchd runs it only while the Mac is awake and you're logged in; a missed slot runs at the
next wake. Check `claude mcp list` first: the Granola connector must show as connected for
headless runs.

## Step 5: Report

```
Saved 4 meetings (transcripts) to ~/Transcripts/
- 2026-09-23_1400_weekly-team-sync.txt
- 2026-09-23_1600_1-1-sam.txt
- ...
Skipped 2 already saved, 1 with nothing recorded (Focus time, Sep 22).
```
