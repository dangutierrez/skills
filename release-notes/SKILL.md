---
name: release-notes
description: Write customer-facing release notes from an issue tracker ticket, a merged pull request, or a rough draft. Use when the user asks for a release note or changelog entry, pastes a draft note to tighten, or asks whether a note covers what actually shipped.
---

# Release notes

Write for **someone reading a changelog**, not for a reviewer reading a diff.
The ticket and the pull request are where the facts come from. Neither one is
the shape of the note.

The most common failure is writing the note from the PR, in the PR's order, at
the PR's length. That produces an accurate note nobody wants to read.

## Order inside the note

1. **What a user can now do.** Lead here, in their words.
2. **What it replaces**, in one clause, and only when the old behavior was
   visible to them. Skip the mechanism.
3. **Caveats** from the checklist below.
4. **What is explicitly not covered**, when a reader would reasonably assume it is.

Lead with the defect only when the change is purely a bug fix with no new
capability. "X used to silently fail, and now it doesn't" is a fine opening for
those.

## Research

**Start with the ticket.** Title, description, comments, labels. Labels often
carry routing information; a `customer-feedback` label means someone asked for
this, and the note should answer them.

**Then read the merged pull request.** The ticket records the problem. The PR
records what shipped. A note written from the ticket alone describes scope that
got cut and misses operational facts the reader needs.

```sh
gh pr list --search "TICKET-123" --state all \
  --json number,title,state,mergedAt,headRefName
gh pr view <n> --json body,files,additions,deletions
```

For GitLab, `glab mr list --search`. Many trackers also surface a linked-PR or
dev-status panel on the ticket itself, so check that before searching.

1. Confirm the PR merged. An open PR is not a release note.
2. Read the PR body in full. It carries what the ticket cannot: what was
   descoped, what the build discovered, deploy steps, rollout pacing, and any
   gates still open at merge.
3. Scan the changed-file list for scope the prose skipped. A new one-off
   migration or backfill task means existing records get rewritten. New hooks,
   jobs, or queue workers mean a rollout delay. Changes to post-deploy config
   mean something fires automatically at release.
4. Diff the ticket's acceptance criteria against what merged. Criteria that did
   not ship are the "not included yet" sentence.

**Then ask the user** for anything operational neither source can state: how long
a backfill takes in production, the publish date, whether a gate is still open,
whether a named account should be called out.

### Sourcing by issue type

**Features, improvements, tasks.** Weight the ticket title and description as the
primary source; comments are supplemental.

**Bugs.** Weight the comments and the PR as primary. Bug descriptions record the
problem as reported, not the fix as implemented, and the two often differ. Use
the title and description for context only.

**Accessibility fixes.** Group them into a single combined note rather than one
entry per ticket.

## Caveat checklist

Run every note against this list. Each item that applies earns one clause and no
more. These are what people open a support ticket about when the note omits them.

- **Backfill.** Do existing records get the new behavior, and how long does that
  take? State the duration and whether any action is needed.
- **New vs existing.** Does this apply only to new records, sessions, or
  attempts? Do records that broke before the fix still need a human to touch them?
- **Latency, scoped to the operation.** Never blanket-warn. If a single edit is
  fast and a bulk operation is slow, say which is which. Warning about the common
  case makes normal behavior look broken.
- **Data prerequisite.** Does the feature do nothing until someone fills in a
  field or turns on a setting?
- **Deferred scope.** What will a reader reasonably assume is included but isn't?
- **Availability.** Is it behind a flag, limited to certain plans, or staged?

## Accuracy traps

Ways a technically true note still misleads the reader.

- **Don't imply UI that doesn't exist.** "Refine," "filter," "select," and
  "choose" promise a control. When the change is that a system now reads a field,
  say that ordinary use matches it and there is no new setting to configure.
- **Don't say "personalize" without per-user behavior.** Reserve it for changes
  that actually vary by user.
- **Don't turn a side effect into a capability.** When people keep doing exactly
  what they did before and it now reaches further, the note is "the tagging you
  already do now drives X," not "you can now use tags to do X."
- **Don't promise speed the rollout doesn't deliver.** Convert the PR's pacing
  numbers into a range someone can plan around.
- **Don't state an outcome the ticket only set as a goal.** If the PR says a
  change "targets perceived speed," write what it does, not what it achieved.
- **Don't name customers the tracker didn't.** If there is an affected-accounts
  field, copy it verbatim and never infer names from the description or comments.
  If it is empty, omit the section. No "possibly" or "may include."

## Structure

**Title.** One sentence-case line naming the primary outcome. Not the ticket
title, which names the defect.

**Body.** Two to three sentences carrying what changed and what it means, plus up
to two more for caveats that apply. One paragraph. Fold the rationale in rather
than splitting it into a separate "Why this matters" section.

**Affected accounts**, only when a tracker field lists them.

**Link** to the ticket or PR, on its own line at the end.

## Rules

- Under 200 words.
- Active voice.
- No internal ticket IDs, branch names, or team conversations in the body copy.
  The link at the end carries the reference.
- No technical detail unless it changes configuration, integrations, or reporting.
- **When several notes ship in one batch, they must read as siblings.** Match the
  length and shape of the notes beside it. A note three times longer than its
  neighbors is wrong even when every sentence in it is true.
- If the project keeps a positioning or messaging doc, align the framing to it.
  Don't invent new strategic framing in a changelog.

## Prose

Cut on sight: `leverage`, `streamline`, `robust`, `empower`, `elevate`,
`seamless`, `transformative`, `cutting-edge`, `game changer`, `unlock the power
of`, `it's worth noting`.

Three patterns that bite release notes hardest:

- **Binary contrasts in titles.** "in seconds, not hours" becomes "within
  seconds again."
- **Parallel sentence openers.** "Users can now... Admins can also..." reads as
  generated. Vary the shape.
- **Importance puffery.** "This marks a major step forward" says nothing. State
  the fact and let the reader judge.

A worked before/after, showing a PR-shaped draft rewritten as a reader-shaped
note, is in `references/worked-example.md`.
