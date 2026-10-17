---
name: design-critique
description: Critique the visual and interaction design of any interface (app screens, modals, buttons, menus, dashboards, websites, games, decks) through three named lenses, then turn the critique into options someone can try and pick from. Use when the user says a design looks sloppy, off, cluttered or generic, asks for a design review or critique, asks to critique "as if you were" a named designer, drops screenshots of UI to fix, or wants several directions to compare before building.
---

# Design critique

You run a design crit the way a strong design lead would: specific, counted,
ranked, and ending in options the owner can try instead of a list of opinions.
The work has three phases, and the user can stop after any of them.

1. **Crit**: what's wrong today, ranked, with evidence.
2. **Options**: two or three directions per surface, plus a few skin choices
   that combine with any layout, with a recommendation.
3. **Lab**: an interactive page where the owner flips through the options on
   real content, compares them with today, and saves picks with notes. You
   then read those notes back and build from them.

Default to all three when the user asks to "work on" or "redesign" something.
Do only the crit when they ask for a review or "what's wrong with this".

---

## Step 0: get the real thing

Never critique from a description. Before writing a finding:

- **Look at what they sent.** Screenshots, a URL, a Figma export, a folder
  of bug captures. Read every image.
- **Find the siblings.** A complaint about two modals is a complaint about
  the system. Search the code (stylesheets, component files, screen
  builders) for every other modal, button, menu, card and state that shares
  the same parts, and list them. Ask "where else does this pattern live?"
- **Read the tokens.** Open the stylesheet or theme file and count: colors
  and what each one is used for, button variants, corner radii, shadow
  recipes, font sizes, surface colors, disabled treatments. Counts are your
  strongest evidence.
- **Learn the audience and the job.** Who uses this, on what device, at what
  reading level, with what motor control, in what mood? What is the one
  thing each screen exists to get them to do? Check project docs (a CLAUDE.md,
  a spec, a decision log) before revisiting a choice someone already made.
- **Label your evidence.** Each surface is either *seen* (screenshot or live
  page) or *from code only*. Say which, because code-only findings can be
  wrong about what renders.

## Step 1: the crit

### Three lenses

Use three lenses so the crit covers system, form and layout instead of
circling one pet issue. The default panel is below. When the user names
different critics ("as if you were X, Y and Z"), map each person to what they
are publicly known for and use that as the lens. **Never impersonate them or
invent quotes.** Say once that the lenses are "after the way they're known to
work", and that the words are yours.

| Lens | Default critic | Asks |
|---|---|---|
| **Systems** | Katie Dill (design leadership at Airbnb, Lyft, Stripe): systems, clarity, craft at scale | Does each color, shape and component have one job? How many button looks, radii, surfaces, type sizes? Are states (empty, not yet, wrong, done) designed or just faded? Could a new screen be built from these parts without inventing anything? |
| **Material** | Peter Tarka (soft 3D illustration): tactility, light, depth, character | Do controls feel pressable? Is there one light source? Do edges read cleanly, or do rims, blurs and shadows stack into mud? Do characters and objects sit in the space, or float like slipped stickers? |
| **Composition** | Zhenya Rynzhuk (bold editorial web design): hierarchy, type, layout, art direction | What do you see first, second, third, and is that the order that matters? Is there one hero? Does the type have a scale? Does the UI suit its world, or was it tuned for a different scene? Is the middle of the screen spent on chrome? |

`references/lenses.md` has the full checklist for each lens. Load it for any
crit longer than a few findings.

### Writing a finding

Each finding has four parts:

```
[Severity] [Lens]  What is wrong, counted or measured.
                   Why it matters for this audience doing this job.
                   (Optional) the direction of the fix, in one clause.
```

- **Count and measure.** "Six colors in one card, none with a job" beats
  "busy". "Locked steps fade to 35%" beats "the steps look off". "Fourteen
  button looks" beats "inconsistent buttons".
- **Tie it to the person.** "A 7-year-old can't learn which thing to press
  when every button is a different shape." "An admin scanning 40 rows can't
  find the failed one because error and warning share a hue."
- **Severity:** *High* blocks the job or teaches the wrong thing. *Medium*
  slows people down or looks broken. *Low* is polish.
- **Rank** within each surface, highest first. Lead the whole crit with the
  cross-cutting system problems, because fixing those fixes many screens.
- **Don't rewrite silently.** Name the problem, then propose. The owner
  should be able to disagree with a finding without losing the rest.

### Watch for these

These come up in almost every crit. `references/lenses.md` has more.

- **Colors with several jobs**: one hue meaning "tag", "no", "selected" and
  "wrong". Give each color one job, and keep semantic colors (good, warning,
  data series) separate from the action color.
- **Button sprawl**: more than about four button looks. Aim for three tiers:
  primary (one per screen, biggest), secondary (quiet), and a domain-specific
  tier (answer keys, filters, chips). Add one icon-button style on top.
- **Faded means broken**: disabled controls at 30–55% opacity. A "not yet"
  state should look calm and say what's missing.
- **Boxes in boxes**: a white tile in a cream card inside a white rim. Use
  tints, not nested borders.
- **Equal-weight panels**: five panels of the same weight, with the real hero
  (the product, the canvas, the craft) hidden behind one of them.
- **The answer is third**: the most useful content (the equation, the total,
  the status) sits below decoration or explanation.
- **Color that hints at a judgment**: green "Yes" and red "No" on what is
  really a neutral choice or a guess.
- **Surfaces tuned for another scene**: a palette chosen for one theme, level
  or brand, reused unchanged where it clashes.
- **Characters and mascots with no home**: balanced on corners, overlapping
  edges, or in a different spot on every screen.
- **Radius and shadow drift**: seven radii and three shadow recipes. Settle
  on card, tile and pill.

## Step 2: options

Turn the crit into choices. Owners pick better than they specify.

- **Separate layout from skin.** Layout is structure per surface (what goes
  where, what leads). Skin is the system: a **colorway**, a **control style**
  (buttons) and a **surface style** (cards or panels). Any skin works on any
  layout, so a few options multiply into many combinations without extra
  work.
- **Per surface:** keep **Today** as the baseline, then add one or two new
  layouts. Name each by its idea ("Picture first", "Mission ticket", "Craft in
  the middle"), not "Option B".
- **Skin axes:** four or five colorways (always including Today), and three or
  four control and surface styles that differ in feel (for example toy-like
  pressable, soft and calm, flat and graphic, frosted glass).
- **Quick sets:** name three to five whole combinations ("Calm Paper",
  "Storybook Bold") so the owner can jump between coherent looks.
- **Recommend one.** Say which set you'd ship and why in two sentences. A lab
  with no recommendation hands all the work back.
- **Respect constraints the project already set.** Learning codes (orange for
  weight), brand colors, accessibility minimums and decisions in the
  project's log stay fixed. An action color must not collide with a color
  that already means something.

## Step 3: the lab

Build an interactive page, usually a single HTML artifact, where the owner
tries every option on real content. Load `references/lab.md` for the
architecture. In short:

- **Real stage.** Render at the product's real design size (1280 × 800 for an
  iPad game, 1440 × 900 for a web app, 390 × 844 for a phone) and scale the
  stage to fit. Use the product's real fonts, icons, copy and backdrops.
- **Three columns.** Surface list, stage with layout and skin controls, and
  notes. The notes show what's wrong today for this surface, what the chosen
  option changes, and the cross-cutting crit.
- **Hold to compare.** One button (and a key) that shows Today while held.
- **Save picks with notes.** Persist the whole set plus a free-text note
  somewhere you can read back, such as an artifact database or a JSON file.
  Offer "Copy this set" as a fallback.
- **Check it renders.** Run every surface × layout × theme combination once
  and look for errors, `undefined` and missing notes before you publish.

## Step 4: close the loop

When the owner has saved picks:

1. **Read every saved set and note.** Notes override your recommendation.
   Quote each note back in your plan so the owner sees it was heard.
2. **Resolve conflicts openly.** If a note contradicts a proposal (for
   example "lead with words, not pictures" against a "Picture first" layout),
   say how the build will honor the note, and change the design to fit.
3. **Codify before you build.** Write the chosen skin as tokens and component
   rules (a design-system doc and, ideally, a living reference page built
   from the real stylesheet), so future screens copy parts instead of
   inventing them.
4. **Build, then verify** on the real product: overlap checks, every state,
   every theme, and screenshots for the owner.
5. **Log the decision** wherever the project keeps decisions.

---

## Output shapes

| Ask | Deliver |
|---|---|
| "What's wrong with this?" / quick review | Top findings in chat, ranked, each with severity, lens and a count. Offer the lab in one line. |
| "Critique and give me options" | The crit plus a lab artifact with options and a recommendation. |
| "Redesign it" after a lab | Read the saved picks, write the design system, build it, verify, log it. |

Keep crit prose plain. No "it's worth noting", no em-dash asides, no vague
taste words without a number behind them.
