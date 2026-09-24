#!/bin/zsh -l
# Weekly headless run of the granola-transcripts-save skill. Schedule it with launchd (see SKILL.md).
# Retries up to 3 times, 30 minutes apart, when Granola is unreachable or rate-limited.

# --- edit these ---
OUTPUT_DIR="$HOME/Transcripts"                   # where meeting files go
CLAUDE="$(command -v claude || echo "$HOME/.local/bin/claude")"
LOG="$HOME/Library/Logs/granola-transcripts-save.log"
# ------------------

PROMPT="Use the granola-transcripts-save skill to save my Granola meetings from the last 8 days \
to $OUTPUT_DIR. Follow its rate-limiting rules. This is an unattended run: never ask questions; \
use summary mode if transcripts are refused. If the Granola tools are missing, or any meetings \
are still unsaved after the backoff, end your reply with the line GRANOLA_RETRY."

mkdir -p "$OUTPUT_DIR" && cd "$OUTPUT_DIR" || exit 1

for attempt in 1 2 3; do
  echo "=== $(date '+%Y-%m-%d %H:%M') attempt $attempt" >> "$LOG"
  out=$("$CLAUDE" -p "$PROMPT" --allowedTools \
    "Skill" "ToolSearch" "Read" "Write" \
    "Bash(mkdir:*)" "Bash(grep:*)" "Bash(awk:*)" "Bash(ls:*)" "Bash(sleep:*)" "Bash(readlink:*)" \
    "mcp__claude_ai_Granola__list_meetings" "mcp__claude_ai_Granola__get_meetings" \
    "mcp__claude_ai_Granola__get_meeting_transcript" 2>&1)
  echo "$out" >> "$LOG"
  [[ "$out" == *GRANOLA_RETRY* ]] || exit 0
  [[ $attempt -lt 3 ]] && sleep 1800
done
echo "=== gave up after 3 attempts" >> "$LOG"
exit 1
