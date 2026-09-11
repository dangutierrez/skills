---
name: ux-survey
description: Write lightweight UX surveys (Google Forms) for platform admins or end users after a feature ships — targeted research questions, general feedback, what worked, or why something went unused. Use when the user wants to survey customers, gather feedback on a released feature, write survey questions, or figure out whether a survey is even the right method.
---

# UX survey writing

You help write short, honest surveys that change a decision. Default audience: admins or power users of a B2B SaaS product who turned on a feature and have lived with it for a few weeks. Default instrument: a Google Form, 5–8 questions, under 3 minutes.

Two jobs:

**Write (default).** The user wants a survey. Work through Step 0, pick a shape, draft it, deliver a Google Forms build sheet plus an invite email.

**Critique.** The user pastes a draft survey. Name each problem against the rules below, quote the question, give the fix. Don't silently rewrite.

---

## Step 0 — earn the survey

Ask these before writing a single question. If the user can't answer them, that is the finding.

1. **What decision is waiting on this?** Get the specific fork. "If most say X, we do A; if most say Y, we do B." A survey whose every outcome leads to the same roadmap is what Antin calls *user-centered performance* — it looks user-centered without informing anything, and it spends goodwill with admins you will need again.
2. **What belief could this prove wrong?** Aim at falsification, not validation. Write down what the team currently believes about the feature, then design the survey so a specific result would contradict it. A survey that cannot come back bad is a press release.
3. **Where does this sit?** Judd Antin's split: *micro* (tactical, how do we fix this feature's next iteration), *middle* (interesting, low consequence), *macro* (strategic, should we keep investing here). Surveys are good at micro and bad at macro. Middle-range is where most surveys die — interesting to read, changes nothing. If the user lands in the middle, push them toward a micro question with a real fork or drop it.
4. **What do you already know?** Product analytics, support tickets, CS call notes, whatever session or event data you already collect. Never ask a survey question a query answers. Admins notice when you ask what your own logs already told you.
5. **Who exactly gets it?** The account list or segment, the headcount, and the send mechanism. Sample size decides what you can claim.
6. **What do they get?** Admins answer when it visibly affects their platform. Say what you will do with it.

### Kill criteria

Say so plainly and name the better method:

| Situation | Do this instead |
|---|---|
| No decision forks on the result | Don't send. Write down why you wanted to. |
| The answer lives in analytics | Run the query. |
| You need depth on *why* | 5–8 interviews beat 200 survey rows. Surveys tell you *what* and *how much*. |
| Audience under ~30 accounts | Email them individually, or book 30-minute calls. A Form to 12 people is worse than 12 emails. |
| The feature shipped last week | Wait. Ask after 2–4 weeks of real use, or you measure first impressions and call it adoption. |
| You want to justify a decision already made | Don't. Ask for the decision to be stated openly instead. |
| You'd be writing the multiple-choice options from guesses | Talk to 5 admins first, then survey to size what they told you. Closed options written cold measure your assumptions, not their experience. |

### Qualitative first, then quantify

Interviews tell you what the landscape is. Surveys tell you how common each part of it is. Run them in that order. A survey built before anyone has talked to an admin measures the option list you invented, precisely and confidently, and sends the team off to fix the wrong thing.

If the user has already done interviews or has support tickets and CS notes on this feature, mine those for the answer options. If they haven't, a Form of open-ends is fine and honest, or 5–8 calls is better. Sample-size rules of thumb: 5–8 conversations surface roughly 85% of usability problems; 8–12 per segment if you're comparing segments; 15–30 for genuinely exploratory work.

---

## Pick the shape

| Intent | Core job | Spine | Main risk |
|---|---|---|---|
| **Targeted question** | Settle one specific fork | Screen for relevant experience → the fork, asked directly → one open-end on reasoning | Burying the fork among filler questions |
| **General feedback** | Find what you didn't know to ask | Behavior → CSAT or CES → two broad open-ends → optional call opt-in | Vagueness in, vagueness out |
| **What worked** | Make a success repeatable and describable | Outcome achieved → what specifically caused it → who else it would suit | Fishing for compliments and collecting quotes with no mechanism in them |
| **Non-adoption** | Learn why it went unused | Last time you had the need → what you did instead → what blocked the feature | Asking "why didn't you use X," which invites polite invented reasons |

### 1. Targeted research question

Put the fork in the first or second question. Everything else supports it.

```
Q1  Screener — have you used [feature] since [date]?  (Yes / No / Not sure)   [branch]
Q2  THE FORK — asked as a choice or a scale, not as an open-end
Q3  Why did you answer that way?  (paragraph, optional)
Q4  Context variable you'll segment by (account size, role, use case)
Q5  Open to a 20-minute call?  (email capture)
```

### 2. General feedback

```
Q1  In the past 30 days, roughly how often did you use [feature]?  (behavioral bands)
Q2  CSAT or CES on [feature]                                      (5-point)
Q3  What has [feature] made easier, if anything?                  (paragraph, optional)
Q4  What has been frustrating or confusing?                       (paragraph, optional)
Q5  If you could change one thing, what would it be?              (paragraph, optional)
Q6  Anything else?  /  call opt-in
```

### 3. Understanding positives

Chase the mechanism, not the compliment. "It's great" is unusable; "it cut our onboarding build from two days to three hours" is a roadmap input and a case study line.

```
Q1  What were you trying to accomplish when you turned on [feature]?  (multi-select + Other)
Q2  Did it accomplish that?  (Fully / Mostly / Partly / Not really / Too early to tell)
Q3  What specifically worked?  Name the step or setting.           (paragraph)
Q4  What did you do before [feature]?  What changed?               (paragraph, optional)
Q5  Which kind of team would get the most out of this?             (paragraph, optional)
Q6  Can we share your experience with other customers?  (email capture)
```

### 4. Understanding non-adoption or abandonment

The people whose answers matter most are the least likely to reply, and direct "why not" questions produce rationalizations. Anchor on the last concrete occasion instead.

Bob Moesta's four forces are the sharpest lens here. A switch happens when **push** (dissatisfaction with the current way) plus **pull** (attraction to the new thing) beats **anxiety** (fear of switching) plus **habit** (the old way still works well enough). Non-adoption means one of those four is the culprit, and they need different fixes — weak pull is a positioning problem, high anxiety is a trust or docs problem, strong habit is an onboarding problem. Write the blocker checklist so every option maps to one of the four, then you can read the counts as a diagnosis instead of a list of complaints.

```
Q1  Which is closest to true for you?
      Never turned it on / Turned it on, never used it /
      Used it a few times then stopped / Still using it   [branch — "still using" exits]
Q2  Think of the last time you needed to [job the feature does].
    What did you actually do?                             (paragraph)
Q3  Which of these got in the way?  (multi-select, concrete blockers + None + Other)
      didn't know it existed           -> pull
      wasn't clear what it did for me  -> pull
      our current way works fine       -> habit
      setup looked like too much work  -> anxiety
      wasn't sure it was safe to turn on for real users -> anxiety
      needed permissions I don't have  -> blocker
      tried it, results weren't right  -> push (against you)
      our process doesn't work that way / we use [other tool]
Q4  What would have to be true for you to try it again?   (paragraph, optional)
Q5  Call opt-in — offer something for their time
```

Send non-adoption surveys from a person, not a product address, and keep them to four questions. Every added question costs you the respondents you most need.

---

## Question rules (Nielsen Norman Group)

1. **Only essential questions.** Every question needs a named use. "Nice to know" is how a 3-minute survey becomes 9 minutes and a 14% response rate.
2. **Neutral, natural, jargon-free.** Write it as you'd say it out loud to an admin. Strip internal names — say "the setting that lets you require a manager to approve requests," not "Approval Gating v2."
3. **No predictions.** People are bad at forecasting their own behavior. Bad: "How likely are you to use this weekly?" Good: "How many times did you use it in the past 7 days?"
4. **Mostly closed-ended.** Closed questions give you countable answers. Open-ends give you language and surprises. See the AI adjustment below for the budget.
5. **One thing per question.** Bad: "How easy and useful was the setup?" Split it.
6. **Balanced scales.** Equal positive and negative options around a neutral midpoint. Bad: Excellent / Very good / Good / Poor / Very poor.
7. **Options all-inclusive and mutually exclusive.** No overlapping bands (0–5, 5–10), no missing top end.
8. **Always an out.** "Not applicable," "I don't know," "Other," "Prefer not to say." Forcing a guess manufactures data.
9. **Almost everything optional.** Required questions buy you either abandonment or noise. Make at most the screener required.
10. **Respect the respondent.** No leading preamble ("We're committed to a five-star experience — how would you rate us?"), no vanity framing, no questions you'd be embarrassed to have quoted back.
11. **Ask about problems, not features.** "What would you build?" turns an admin into a junior PM and returns a wishlist you can't prioritize. Ask what got in their way and what they did instead. "What would you change about X?" is acceptable as a last open-end because it reliably surfaces the sorest spot, but read the answers as complaints with a location attached, not as specs.

---

## The AI-native adjustments (Judd Antin)

Classic survey advice minimizes open-ended questions because coding free text was slow and expensive. That cost has largely collapsed. Adjust, carefully:

- **Budget 2–3 open-ends instead of one.** Free text is where you learn what you didn't know to ask. Keep them optional and keep them last.
- **Read the verbatims.** Use AI to cluster and count; don't let a summary stand in for the raw answers. Antin's term for the failure is *ResearchSlop* — plausible, fluent output that nobody checked against what people actually said. Quote real sentences in whatever you circulate.
- **Never fabricate respondents.** No synthetic users, no simulated personas filling a thin sample. Eleven real admins reported as n=11 is worth more than 200 generated rows, and one discovered fake number ends the program.
- **AI is a research assistant, not the researcher.** It drafts, pilots, codes, and clusters. Deciding what question matters and what the answer means for the roadmap stays human.
- **Pilot before sending.** Role-play three distinct admins — a power user at a 50k-seat account, a part-time admin at a small one, someone who enabled the feature and forgot about it — and answer the draft as each. Flag any question they can't answer, would read two ways, or would find annoying. Then cut a question.
- **Report the sample honestly.** Response count, invited count, and who is missing. "31 of 140 admins, skewed toward accounts over 10k seats" beats a bare percentage.

---

## Scales to reuse

**CSAT (satisfaction with a specific thing)**
> How satisfied are you with [feature]?
> Very satisfied / Satisfied / Neither satisfied nor dissatisfied / Dissatisfied / Very dissatisfied / Haven't used it

**CES (effort — the best single item for admin tooling)**
> [Feature] made it easy to [job].
> Strongly agree / Agree / Neither / Disagree / Strongly disagree / Not applicable

**Outcome achievement**
> Fully / Mostly / Partly / Not really / Too early to tell

**Behavioral frequency (past 30 days)**
> Not at all / Once / 2–5 times / 6–15 times / More than 15 times / Don't remember

Skip NPS. Antin dismisses it as a UX instrument and CSAT or CES tells you more about a specific feature. If someone insists on NPS, put it last and never let it be the only measure.

---

## Length and order

- 5–8 questions. Four for a non-adoption survey.
- Order: screener → easy behavioral → the core measure → open-ends → optional contact capture.
- Never open with an open-ended question. People bail on a blank box before they've invested anything.
- Show a real time estimate in the invite. If the pilot took four minutes, don't write "2 minutes."

---

## Deliverable format

Produce a **Google Forms build sheet** the user can type in directly:

```
FORM TITLE:       [short, names the feature, no internal codename]
FORM DESCRIPTION: [2 sentences — why you're asking, how long, what you'll do with it]
SETTINGS:         Collect email = [on/off + why] · Limit to 1 response = [on/off] ·
                  Progress bar = on · Confirmation message = [text]

SECTION 1 — [name]
Q1. [exact question text]
    Type:     Multiple choice
    Options:  [each option on its own line, including the opt-out]
    Required: Yes
    Logic:    "No" → go to Section 3
    Purpose:  [one line — which decision this feeds]
...
```

Google Forms mechanics worth knowing: sections give you branching ("Go to section based on answer" on multiple-choice questions only), *Linear scale* for 1–5 with labeled ends, *Short answer* vs *Paragraph* (use Paragraph for anything asking "why"), *Checkboxes* for multi-select, and response validation for numbers. Branching needs each branch target to be its own section, so plan the sections before typing questions.

Then give the **invite email**: subject line, 3–4 sentence body naming the feature, the honest time estimate, what you'll do with the answers, a deadline about 7 days out, and a single link. Send from a named person. Follow up once after 4 days to non-responders, never twice.

Close the loop afterward. Tell respondents what changed. It is the only thing that makes the next survey work.

---

## Pre-send checklist

- [ ] Every question maps to a decision, written down
- [ ] Nothing asked that analytics already answers
- [ ] No internal feature names or jargon
- [ ] No question predicts future behavior
- [ ] No double-barreled questions
- [ ] Scales balanced, options exhaustive and non-overlapping
- [ ] Every question has an opt-out
- [ ] Only the screener is required
- [ ] Open-ends optional and last
- [ ] Piloted against three imagined admin profiles
- [ ] Time estimate measured, not guessed
- [ ] Under 8 questions
- [ ] Someone named owns reporting back to respondents

---

## Prose quality

Survey text, invites, and the writeup all count as prose. Check them against `~/.claude/skills/no-ai-slop/SKILL.md` before delivering. Survey copy in particular attracts throat-clearing ("We'd love to hear your thoughts!") and empty enthusiasm. Cut it.

## Reference

`references/question-bank.md` — reusable question wordings by intent, and the common ways each goes wrong.
