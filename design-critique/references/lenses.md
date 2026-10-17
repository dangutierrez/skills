# Lens checklists

Work through the lens that fits the finding. You don't need every question
for every surface. These checklists keep the crit from circling one pet issue.

## Systems lens (default: Katie Dill)

Design systems, clarity, consistency, craft at scale.

**Inventory: count these first.**
- Colors, and the job of each. Write a table: color → every place it's used →
  what it means there. Any color with more than one meaning is a finding.
- Button looks: every distinct combination of shape, fill, edge and size.
- Corner radii: list every value. More than about four is drift.
- Surface colors: card, panel, bubble, tile, sheet. Different surfaces that
  play the same role should match.
- Shadow and edge recipes: borders, rims, blurs, drop shadows.
- Type sizes and weights: is there a scale, or a pile of one-off sizes?
- Tag and label styles: pill, eyebrow, badge. How many, and is there a rule
  for which goes where?

**States.** For each interactive part, is there a designed version of:
- empty or zero ("nothing loaded yet")
- not yet available, and does it say why?
- selected or current
- done or correct
- wrong or failed, and is it gentle enough for the audience?
- loading

**Semantics.**
- Is the action color separate from semantic colors (good, warning, error)
  and from domain codes (data series, learning codes, brand categories)?
- Does color ever carry meaning alone? Add shape, icon or text.
- Do neutral choices look neutral? A guess, a preference or a fork in a flow
  shouldn't wear right and wrong colors.

**Reuse test.** Could someone build the next screen from these parts without
inventing a new button or card? If not, the system is incomplete.

## Material lens (default: Peter Tarka)

Form, tactility, light, depth, character.

- **Pressability.** Do primary controls look like you can push them? A thin
  edge reads as flat. A thicker base, a top highlight and a press that moves
  the button fully onto its base read as physical.
- **One light source.** Shadows fall the same direction and softness across
  cards, buttons and characters.
- **Clean edges.** Each surface has one edge treatment. A rim plus a blur
  plus a large soft shadow makes muddy edges, especially over busy
  backgrounds.
- **Depth order.** Background (world), then mid (characters, the thing being
  made), then front (panels, controls). Does anything break the order, like
  a panel sitting on the hero or a character pasted over a card edge?
- **Characters and mascots.** Each has one home per screen. They peek from
  behind a surface, stand on the ground, or sit beside their speech bubble.
  They don't balance on corners or overlap edges at random.
- **Material fit.** Does the surface material suit the world? Paper for warm
  daytime scenes, glass for night or space, solid sheets for dense tools.
- **Zero states.** An empty meter should look calm (an empty tube), not
  broken (40 grey stripes).

## Composition lens (default: Zhenya Rynzhuk)

Hierarchy, type, layout, art direction.

- **Reading order.** Write down what you see 1st, 2nd and 3rd. Then write
  what matters 1st, 2nd and 3rd. Every mismatch is a finding.
- **One hero per screen.** The product, the canvas, the craft, the chart.
  Panels sit around it, not on it.
- **One primary action**, and it's the biggest control. Secondary actions
  get smaller and quieter, never three equal pills in a row.
- **Type scale.** Display, title, body and caption, each with a reason to
  exist. Headings balance across lines. Running text stays near 65
  characters for adults; for early readers, put one sentence per line with
  clear space between sentences.
- **Alignment.** Shared left edges, consistent baselines across sibling
  cards, labels at the same height in neighboring groups. Ragged starts and
  stray indents read as sloppy before anyone can say why.
- **Density for the audience.** Children and first-time users get fewer,
  bigger things. Experts get density, but scannable density with summary
  before detail.
- **World fit.** Palette, shadow color and surface tone should come from the
  scene the UI sits on. A warm brown text shadow tuned for a desert looks
  muddy over a night sky.
- **Words versus pictures.** Decide on purpose what leads. For a reading
  app, words lead and pictures help on request. For a pre-reader or a
  glance-only dashboard, pictures lead.

## Audience notes

- **Young children (5–8).** Large targets (60 px or more), one sentence per
  line, read-aloud everywhere, failures that never feel like failing,
  grown-up controls that need a hold or a gate, no color-coded judgment on
  guesses. Check whether pictures are doing the reading for them when
  reading is the goal.
- **Older adults.** Contrast, larger type, fewer simultaneous choices, labels
  on icons.
- **Experts and operators.** Density, keyboard paths, stable layouts,
  semantic color reserved for state.
- **Executives and stakeholders.** The answer first, then evidence. One
  number per tile only when the number is the point.
