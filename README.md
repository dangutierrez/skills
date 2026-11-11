# skills

Claude Code skills I use. Each directory is one skill: a `SKILL.md` with YAML frontmatter, plus any reference files it loads on demand.

## Skills

| Skill | What it does |
|---|---|
| [`design-critique`](design-critique/) | Critiques any interface (screens, modals, buttons, menus, dashboards, sites, games) through three lenses: systems, material and composition, by default after Katie Dill, Peter Tarka and Zhenya Rynzhuk. Findings are counted and ranked rather than vague. Then it turns the crit into layout and skin options in an interactive lab, reads back the picks and notes the owner saves, and codifies the winner as a design system. |
| [`granola-transcripts-save`](granola-transcripts-save/) | Saves Granola meetings to a local folder as plain-text files named by date, one per meeting, and skips ones already saved. Writes verbatim transcripts on paid Granola plans and falls back to the AI summary plus your notes on the free plan, since the connector withholds transcripts there. |
| [`release-notes-jira`](release-notes-jira/) | **Jira only.** Writes customer-facing release notes from a Jira issue and its merged PR. Sources facts from both, orders them for a reader rather than a reviewer, and runs a caveat checklist (backfill, rollout latency, deferred scope) plus an accuracy-trap list that catches notes which are true but misleading. Every note gets a publish status (public, hold, internal-only), bug-fix notes claim only the scenarios the issue covers, and a PR that never reached the default branch holds the note. A completed epic gets one combined note. |
| [`release-notes-linear`](release-notes-linear/) | **Linear only.** The same writing rules, sourced from Linear: issue type from labels, comments fetched separately, archived issues included, affected accounts from customer requests, labels, description and comments (Linear has no custom fields), and one combined note per completed project. Covers the Jira-import traps too, such as imported projects all showing the import date as their completion date. |
| [`ux-survey`](ux-survey/) | Writes short post-launch UX surveys as Google Forms build sheets, and pushes back when a survey is the wrong instrument. Built on Nielsen Norman Group's question-writing rules, Judd Antin's research-value framing, and Bob Moesta's four forces. |

## Install

Clone anywhere and symlink the skills you want into `~/.claude/skills/`:

```sh
git clone https://github.com/dangutierrez/skills.git ~/repos/skills
ln -s ~/repos/skills/ux-survey ~/.claude/skills/ux-survey
```

Claude Code picks them up on the next session. Invoke with `/ux-survey`, or let Claude route to one from the description in its frontmatter.

Per-project skills go in `.claude/skills/` inside the repo instead.
