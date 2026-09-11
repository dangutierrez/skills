# Question bank

Reusable wordings. Swap `[feature]` for how admins would describe it in their own words, not the internal name. Every closed question here assumes an opt-out option is added.

---

## Screeners

> Have you turned on [feature] for your site?
> Yes, and we've used it · Yes, but we haven't really used it · No · Not sure

> Which is closest to true for you?
> Never turned it on · Turned it on but never used it · Used it a few times then stopped · Still using it regularly

Branch on these. The four-way version is the single most useful question in a post-launch survey because it splits your respondents into groups that need completely different follow-ups.

---

## Behavior (past tense, bounded window)

> In the past 30 days, roughly how often did you use [feature]?
> Not at all · Once · 2–5 times · 6–15 times · More than 15 times · Don't remember

> Roughly how many [users / projects / records] have you used [feature] with?
> None yet · 1–10 · 11–100 · 101–1,000 · More than 1,000 · Don't know

> Who on your team uses [feature]? (select all)
> Just me · Other admins · Managers · End users · Nobody yet · Other

**Never:** "How often do you typically use..." — typically invites an aspirational answer. Bound it in time and put it in the past.

---

## Satisfaction and effort

> How satisfied are you with [feature]?
> Very satisfied · Satisfied · Neither · Dissatisfied · Very dissatisfied · Haven't used it enough to say

> [Feature] made it easy to [specific job].
> Strongly agree · Agree · Neither · Disagree · Strongly disagree · Not applicable

> Setting up [feature] took about as long as I expected.
> Strongly agree · Agree · Neither · Disagree · Strongly disagree · Someone else set it up

Effort beats satisfaction for admin tooling. Admins rarely love configuration screens; they notice when one costs them an afternoon.

---

## Outcome

> What were you hoping [feature] would do for you? (select all that apply)
> [3–6 concrete outcomes drawn from interviews or CS notes] · Something else (please describe) · I was just trying it out

> Did it do that?
> Fully · Mostly · Partly · Not really · Too early to tell

> Compared to how you did this before, [feature] is:
> Much better · Somewhat better · About the same · Somewhat worse · Much worse · We didn't do this before

The last one is the closest a survey gets to a before/after measure. Pair it with an open-end asking what changed.

---

## Open-ends that produce usable text

Good open-ends are anchored — to a moment, a task, or a comparison. Unanchored ones ("Any thoughts on [feature]?") return "great, thanks."

> Think of the last time you used [feature]. What were you trying to get done?
> What worked well? Please name the specific step or setting.
> What was confusing or frustrating?
> What did you do to handle this before [feature] existed?
> What would have to be true for you to use it more?
> If you could change one thing about it, what would it be?
> Is there anything we should have asked you about but didn't?

That last question earns its place in almost every survey. It catches the thing your option lists missed.

---

## Non-adoption blockers, mapped to the four forces

Present as a multi-select. Each option should map to push, pull, anxiety, or habit so the counts read as a diagnosis.

| Option text | Force | What it means you fix |
|---|---|---|
| I didn't know it existed | pull | Announcement, in-product discovery |
| I wasn't clear what it would do for me | pull | Positioning, empty state, docs |
| Our current process works fine | habit | Need a sharper wedge, or this isn't a real problem |
| Setup looked like more work than it was worth | anxiety | Onboarding, defaults, setup time |
| I wasn't confident turning it on for real users | anxiety | Preview mode, rollback, trust signals |
| I don't have permission to enable it | blocker | Roles, or target the right person |
| I tried it and the results weren't right | push, against you | Quality. Follow up individually. |
| It doesn't fit how our organization works | fit | Possibly correct non-adoption. Note the segment. |
| We use another tool for this | competition | Ask which one in a follow-up |

Always include **None of these** and **Other (please describe)**.

---

## Contact and follow-up

> We'd like to understand this better. Can we book 20 minutes with you?
> Yes — my email is: ____ · No thanks

> Can we share what you told us with other customers considering [feature]?
> Yes, with my name and company · Yes, anonymously · No

Put contact capture last and make it optional. If the Form collects email automatically, say so in the description rather than surprising people at the end.

---

## Wordings to retire

| Instead of | Ask |
|---|---|
| How likely are you to recommend [feature] to a colleague? (0–10) | How satisfied are you with [feature]? or the CES agreement item |
| How likely are you to use this in the future? | How many times did you use it in the past 30 days? |
| How easy and useful was [feature]? | Two separate questions |
| Do you agree that [feature] is a valuable addition? | How satisfied are you with [feature]? |
| Why didn't you use [feature]? | Think of the last time you needed to [job]. What did you do? |
| What features would you like to see next? | What got in your way the last time you tried to [job]? |
| Any other thoughts? | Is there anything we should have asked you about but didn't? |
| We're committed to making admin work easier. How are we doing? | Drop the preamble entirely |
