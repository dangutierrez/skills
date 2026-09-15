# skills

Claude Code skills I use. Each directory is one skill: a `SKILL.md` with YAML frontmatter, plus any reference files it loads on demand.

## Skills

| Skill | What it does |
|---|---|
| [`release-notes`](release-notes/) | Writes customer-facing release notes from a ticket and its merged PR. Sources facts from both, orders them for a reader rather than a reviewer, and runs a caveat checklist (backfill, rollout latency, deferred scope) plus an accuracy-trap list that catches notes which are true but misleading. |
| [`ux-survey`](ux-survey/) | Writes short post-launch UX surveys as Google Forms build sheets, and pushes back when a survey is the wrong instrument. Built on Nielsen Norman Group's question-writing rules, Judd Antin's research-value framing, and Bob Moesta's four forces. |

## Install

Clone anywhere and symlink the skills you want into `~/.claude/skills/`:

```sh
git clone https://github.com/dangutierrez/skills.git ~/repos/skills
ln -s ~/repos/skills/ux-survey ~/.claude/skills/ux-survey
```

Claude Code picks them up on the next session. Invoke with `/ux-survey`, or let Claude route to one from the description in its frontmatter.

Per-project skills go in `.claude/skills/` inside the repo instead.
