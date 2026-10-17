# Building the iteration lab

A lab is one page where the owner flips through layouts and skins on real
content, compares them with today, and saves what they like. Build it as a
single HTML file (an artifact, or a file in the project's `tools/` folder).

## Architecture

```
┌──────────┬──────────────────────────────────────┬───────────────┐
│ Surfaces │ Surface name   [Today|A|B]  [Theme…] │ What's wrong  │
│  list    │ ┌──────────────────────────────────┐ │ today         │
│ (flag    │ │  stage: real size, scaled to fit │ │               │
│  the bug │ │  backdrop + layout(content)      │ │ What this     │
│  ones)   │ └──────────────────────────────────┘ │ option does   │
│          │ Quick sets: Today | Pick | …         │               │
│          │ Colorway | Controls | Surfaces       │ Save set +    │
│          │                                      │ saved sets    │
└──────────┴──────────────────────────────────────┴───────────────┘
```

**Skin as tokens.** Each colorway is an object of named tokens (surface,
surface-2, ink, ink-soft, line, primary, primary-edge, primary-ink,
secondary, key, tag, info, speaker or icon-button, semantic colors, domain
codes, outline, shadow). Apply them as CSS custom properties on the stage
element. Component CSS reads only tokens, never literal colors, so any
colorway works on any layout. A colorway can carry per-theme tints (one set of
surface tokens per world, brand or mode).

**Control and surface styles as classes.** Put `bs-<style>` and `cs-<style>`
on the stage and write each style's rules against shared variables:
`--fill`, `--edge` and `--fg` on every button variant, so primary, secondary
and key buttons all inherit the active style.

**Layouts as functions.** `R[surface][layout](content) → HTML string`. Each
surface has `current` (Today) plus one or two new layouts. Content comes from
a per-theme object (titles, items, numbers), so switching the theme changes
the words too.

**Stage scaling.** A wrapper with `aspect-ratio` set to the design size. The
stage is absolutely positioned at the design size with
`transform: scale(wrapperWidth / designWidth)`, updated by a
`ResizeObserver`. Everything inside is laid out in design pixels.

**Use the product's real assets.** Export icons from the codebase (a short
script that imports the icon module and prints JSON), load the real fonts,
and copy real strings.

## Behaviors

- **Hold to see today.** Pointer-down or a held key (T) renders with
  colorway, controls, surfaces and layout all set to Today. Show a "TODAY"
  badge while held.
- **Keyboard.** Up and down change surface; left and right change layout.
- **Live states.** Wire the interesting states (right and wrong answer,
  selected, not ready) to clicks inside the stage so the owner can feel
  them.
- **Notes per surface.** What's wrong today (severity, lens, finding), what
  the current option changes, and the cross-cutting crit in a collapsible
  section.
- **Recommendation.** A short "My pick" box at the top of the notes.
- **Save set.** Save the colorway, controls, surfaces, theme, the layout chosen
  for every surface, and a note. Use a shared store you can read back (an
  artifact database collection such as `picks`). Fall back to localStorage
  with a "Copy this set" button that copies a plain-text summary.
- **Remember the view** (surface, skin, layouts) in localStorage as a
  per-viewer convenience.

## Before publishing

- Run every surface × layout × theme in Node (stub only what the render
  functions need) and fail on thrown errors, `undefined`, `NaN` and missing
  notes.
- Take one look at the rendered page, fix what you see, and publish.
- After publishing, read the picks collection once to confirm the store
  answers.

## After the owner saves

Read the collection, quote every note back, and say how each one changes the
build. Notes beat your recommendation.
