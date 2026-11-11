---
name: release-notes-linear
description: Write customer-facing release notes from Linear issues and projects (Linear only; for Jira use release-notes-jira). Works from the issues that carry your team's release-note label, issue keys you name, a merged pull request, or a rough draft, and gives every note a publish status (public, hold, internal-only). Use when the user asks for a release note or changelog entry for Linear work, pastes a draft note to tighten, or asks whether a note covers what actually shipped.
---

# Release notes (Linear)

This version reads Linear through the Linear MCP connector. `release-notes-jira`
has the same writing rules with Jira sourcing.

Write for **someone reading a changelog**, not for a reviewer reading a diff.
The issue and the pull request are where the facts come from. Neither one is
the shape of the note.

The most common failure is writing the note from the PR, in the PR's order, at
the PR's length. That produces an accurate note nobody wants to read.

## Settings

Fill these in once. Anything left "not set" falls back to the default in brackets.

- **Workspace URL:** `https://linear.app/<workspace>`
- **Default team key:** `ABC`
- **Release-note label:** not set [ask the user for issue keys]
- **Repos to search for PRs:** not set [search the whole GitHub org]
- **Messaging doc:** none [write from the issue and flag the note for review]
- **Team rules:** none [see "Team rules" at the end]

Pick the team in this order: keys in the request ("release notes for ABC-123"),
then the argument (`/release-notes-linear ABC`), then a team named in the
request, then the default.

**Which issues.** The issues that carry the team's release-note label
(`list_issues(team="ABC", label="<label>", includeArchived=true)`), the keys the
user names, or a pasted draft. Release-note labels are usually team labels, so
each team needs its own; another team's issues can't carry it.

## Reading the issue in Linear

- `get_issue(id="ABC-123", fields=["title","description","status","labels","project","parentId","attachments","relations","customerNeeds","url","completedAt"])`.
- `list_comments(issueId="ABC-123")`. `get_issue` doesn't include comments.
  Inline comments on the description come back with the text they quote.
- **Archived issues.** Linear auto-archives closed issues after a period the team
  sets, and an import can archive every completed issue at once. `get_issue` by
  key still works; a `list_issues` search needs `includeArchived=true`.
- **Issue type comes from labels.** Linear has no issue types. Most workspaces
  keep a label group for them (Bug, Feature, Improvement). No type label means
  task.
- **Epics are projects.** A sub-issue with no project of its own belongs to its
  parent's project; check the parent with `get_issue(id=parentId, fields=["project"])`.
- **PRs.** With the GitHub integration on, a PR whose branch, title or body names
  the key shows up in the issue's attachments. If none is attached, search GitHub
  by key (see Research).
- **Imported from Jira?** Imported issues usually carry an attachment linking
  back to the Jira issue. Treat it as history. If keys changed in the import,
  PRs written before it name the old Jira key, so search GitHub for both.

## Publish status

Give every note one status and print it on the line above the title:
`Publish: public`, `Publish: hold (<reason>)` or `Publish: internal-only (<reason>)`.
Write the note in every case; the status says where it goes. Keep the reason to
the short label from the lists below, for example `Publish: hold (in beta)`. Put
the details (which flag, which issue, how many accounts) in your message to the
user, not on the Publish line.

- **public:** on the default branch, live for customers, and nothing below applies.
- **hold:** the note waits on something. Use one of these reasons:
  - `not on default branch`: the PR merged into a feature branch, or its merge
    commit hasn't reached the default branch.
  - `not released`: the feature hasn't launched (the messaging doc or the project says so).
  - `in beta`: the feature flag is on only for beta or selected accounts.
  - `flag off`: the feature flag is off for every account.
  - `PR not checked`: GitHub wasn't reachable, so the default-branch check didn't run.
- **internal-only:** the note is for staff, not the changelog. Use one of these
  reasons, or one your team rules add:
  - `prototype`: say plainly that the prototype changes nothing in production.
  - `one customer` or `staging only`: work for one customer only, or on a staging
    site only.
- **No note:** internal work with nothing for customers: UAT and QA tasks,
  research and parity inventories, audits, test-suite cleanup. List these with a
  one-line reason each. Tech debt that changes customer-visible behavior gets a
  normal note.

## Completed projects

When a project's status is Completed and its issues are in the batch, write one
combined note for the project instead of one note per issue.

- Read every issue in the project, with the same sourcing rules as single issues.
- Cover the customer-facing changes as one group: what users or admins see now,
  across the whole project. Name the areas the changes touched (the languages,
  the screens), not each issue.
- Leave out issues that would get no note or an internal-only note, and say which
  ones you left out.
- Affected accounts: every account that qualifies on any of the project's issues.
  `list_customer_needs(project="<project>")` returns the customer requests across
  all of them.
- Link the project (`https://linear.app/<workspace>/project/<slug>`) first, then
  each issue.
- One Publish status for the note. If any covered change isn't on the default
  branch, the note is `hold (not on default branch)`.
- If no issue in it is customer-facing, write no note and list the project.

**Finding projects that completed in a window.** `list_projects` can't filter on
`completedAt`. Narrow with `list_projects(team="ABC", state="completed", updatedAt="-P7D", includeArchived=true)`,
then keep the projects whose `completedAt` falls in the window.

**After a Jira import,** every imported completed project shows `completedAt` as
the import time, so a "completed this week" filter returns every closed epic in
the team's history. For those, date the project by the latest `completedAt` among
its issues that completed before the import. Don't use issues completed after the
import: they closed under a project that was already Completed.

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

**Start with the issue.** Title, description, comments, labels. Labels often
carry routing information; a `customer-feedback` label means someone asked for
this, and the note should answer them.

**Then read the merged pull request.** The issue records the problem. The PR
records what shipped. A note written from the issue alone describes scope that
got cut and misses operational facts the reader needs.

```sh
gh pr list -R <org>/<repo> --search "ABC-123" --state all \
  --json number,title,state,mergedAt,baseRefName,headRefName
gh search prs "ABC-123" --owner <org>
gh pr view <n> -R <org>/<repo> --json body,files,baseRefName,mergeCommit
```

1. **Find every PR.** Start with the issue's attachments. Then search each repo
   in Settings, then the whole org. Also read every PR a comment links to; some
   issues name their PRs only in comments. If an attached PR doesn't name the key
   in its title or body, still read it and use it, and tell the user which PR
   that was. Imports and manual links can attach another issue's PR.
2. **Confirm it merged into the default branch.** Look the branch up with
   `gh repo view <org>/<repo> --json defaultBranchRef`. A PR merged into a
   feature branch hasn't shipped. For stacked PRs, check that the merge commit
   reached the default branch:
   `gh api repos/<org>/<repo>/compare/<merge sha>...<default branch> --jq .status`
   returns `ahead` or `identical` when it has. If it hasn't, still write the
   note and mark it `hold (not on default branch)`.
3. **Read the PR body in full.** It carries what the issue cannot: what was
   descoped, what the build discovered, deploy steps, rollout pacing, and any
   gates still open at merge.
4. **Scan the changed-file list** for scope the prose skipped. A new one-off
   migration or backfill task means existing records get rewritten. New hooks,
   jobs, or queue workers mean a rollout delay. Changes to post-deploy config
   mean something fires automatically at release.
5. **Diff the issue's acceptance criteria against what merged.** Criteria that
   did not ship are the "not included yet" sentence.

**Then ask the user** for anything operational neither source can state: how long
a backfill takes in production, the publish date, whether a gate is still open.

### Sourcing by issue type

**Features, improvements, tasks.** Weight the issue title and description as the
primary source; comments are supplemental.

**Bugs.** The merged PR and the comments written after the fix are the source of
truth for what changed. When they conflict with the description or with earlier
comments, they win. Still read the description and every comment: they hold the
broken scenario, what users saw, and who reported it. Bug descriptions record the
problem as reported, not the fix as built, and an early comment can argue for an
approach that didn't ship.

**Accessibility fixes.** Group them into a single combined note rather than one
entry per issue.

## Writing bug-fix notes

Describe the fix precisely, scoped to the area it touched. Name the scenario that
was broken, what the user saw, and what happens now.

- State only what the PR and the later comments confirm changed. Don't widen the
  claim beyond the scenarios the issue covers.
- Don't say a problem is fixed "in all scenarios," "in every case," or "for all
  users," and don't say it was broken "in many cases," unless the issue states
  that scope.
- Don't add reassurance or benefits the fix doesn't deliver.
- If the issue covers two scenarios, describe those two and stop.
- Title the specific fix ("Fixed: card payments that left buyers without their
  order"), not a broad outcome.
- **Security, payment and data-integrity fixes.** Say what's protected now and
  what, if anything, a customer or developer has to change. Never describe how
  the gap could be exploited, and never mention a related gap that's still open.

## Affected accounts

Linear has no custom fields, so there is no single affected-accounts field to
copy. Look in these places, in order, and note where each name came from:

1. Customer requests, if the workspace uses Linear's Customers feature:
   `list_customer_needs(issue="ABC-123")`, or `customerNeeds` on `get_issue`.
2. Labels that name a customer account.
3. The description: a section your issue template keeps for affected customers,
   a sentence saying an account is affected, reported the issue, or asked for the
   change, or, on an issue imported from Jira, the old field's value if the import
   copied custom fields into the description (often a table at the end).
4. The comments, on the same test.

Rules:

- Copy account names as written. Don't paraphrase, abbreviate, or guess.
- Treat "All" as empty.
- Never infer a customer from symptoms, environments, or domains. Skip a customer
  named only as a test participant, in setup steps, or as an example.
- The title doesn't count on its own. "[Acme]" in an issue title qualifies only
  when a customer request, a label, the description, or a comment names Acme too.
- If no account qualifies, omit the section.
- One account per line. No "possibly" or "may include."
- Customer names appear only in this section, never in the note's title or body.

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
- **Availability.** Is it behind a flag, limited to certain plans, or staged? The
  Publish status carries most of this; the note says only what a reader can act on.

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
- **Don't state an outcome the issue only set as a goal.** If the PR says a
  change "targets perceived speed," write what it does, not what it achieved.
- **Don't name customers outside the Affected accounts section,** and don't
  name any that section's rules don't allow.

## Structure

**Publish line.** `Publish: <status>` on the line above the title.

**Title.** One sentence-case line naming the primary outcome. Not the issue
title, which names the defect.

**Body.** Two to three sentences carrying what changed and what it means, plus up
to two more for caveats that apply. One paragraph. Fold the rationale in rather
than splitting it into a separate "Why this matters" section.

**Affected accounts**, only when an account qualifies.

**Developer block** (API changes only), just above the link: the endpoint, the
required scope, and the status codes. It may name endpoints, headers and status
codes. Never feature flags.

**Link** to the issue (`https://linear.app/<workspace>/issue/ABC-123`) on its own
line at the end. A combined project note links the project first, then each issue.

## Rules

- Under 200 words.
- Active voice. No em dashes.
- Use customer-facing terms. No feature flag names, code identifiers, field codes,
  internal code names, issue keys, or branch names in the title or body. Say what
  it means to the customer: "accounts that use the built-in video player," not
  the flag that turns it on. The developer block is the one exception, and it
  still never names a flag.
- No technical detail unless it changes configuration, integrations, or reporting.
- **When several notes ship in one batch, they must read as siblings.** Match the
  length and shape of the notes beside it. A note three times longer than its
  neighbors is wrong even when every sentence in it is true.
- Every note carries a Publish line.

### Messaging docs

If the team keeps a positioning or messaging doc, align the framing to it, and
don't invent new strategic framing in a changelog. For a product area with its own
messaging doc (an AI feature set, say):

- Read it fresh each run. Messaging docs are living drafts.
- Use its product names exactly, including capitalization.
- Check the release status it gives the feature. If it conflicts with the issue,
  flag the conflict to the user rather than picking one.
- If the doc moved or can't be read, say so and ask for the current link.

Never copy these from an internal messaging doc into a note: named customers,
quote IDs, or buyer quotes; competitor names or comparisons; proof points marked
unapproved or internal; win/loss or pipeline figures; copy for features the doc
marks unreleased, unless the issue confirms the feature ships.

With no messaging doc, write from the issue and flag the note for whoever owns
product marketing to review.

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

## Before returning

Check every note:

- [ ] A Publish line sits above the title, with a short reason for hold or internal-only.
- [ ] Caveats are two sentences or fewer.
- [ ] Customer names appear only under Affected accounts.
- [ ] No flag names, code identifiers or field codes in the title or body.
- [ ] Bug fixes claim only the scenarios the issue covers.
- [ ] Under 200 words, and close in length to its neighbors.

List the issues that got no note, each with a one-line reason.

## Team rules

Add a section here when your team has rules of its own. Three kinds come up:

- **Exclusions.** Work streams that never get notes, such as a rebuild that ships
  behind its own launch. Say how to recognize them (project, initiative, label,
  branch) and never mention them in other notes. Check an issue's parent too: a
  sub-issue with no project inherits its parent's.
- **Extra internal-only reasons.** For example, security hardening the team
  doesn't announce, with the exception that a change external developers can see
  gets a public note after someone confirms it.
- **Standing holds.** A feature in beta stays `hold (in beta)` until its flag is
  on for every account.
