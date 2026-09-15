# Worked example

A real shape of change, anonymized: semantic search over a content catalog was
embedding only each item's title, summary, description, and body. Tags and
categories were extracted but written to a field the embedding pipeline never
read. Difficulty, credential, and format were read by nothing at all. Keyword
search indexed all of it, so an item tagged `osha-required` was findable in
keyword search and invisible to semantic search for the same query.

## What the PR actually shipped

Worth listing, because the ticket only described the first item:

- A five-field metadata block (Topics, Tags, Difficulty, Format, Credential)
  added to the embedded text
- Reaching all 15 content-type extractors, where the shared header previously
  covered 3
- Tag names emitted in the item's locale, falling back to the raw name
- Five hooks so taxonomy edits queue a reindex at all — nothing did before
- Bulk operations (rename, CSV import, delete) draining at ~2,000–2,500
  items/hour
- A backfill task firing at deploy for existing items
- Paths and collections inheriting their children's metadata
- Duration, rating, and points explicitly deferred; they need filter columns,
  not embedding

## Draft 1: PR-shaped (wrong)

> **Search reads item topics and tags**
>
> Search embedded only item title, summary, description, and body content.
> Admin-curated topics and tags never reached the vector index, so an item
> findable by tag in keyword search returned nothing in semantic search for the
> same query. Topics and tags now go into the indexed text alongside the title
> and summary, and a taxonomy change queues a rebuild so the index stays
> current. Difficulty, credential, and format land as searchable words in the
> same change.

What's wrong: it opens with the defect, in the PR's words. The title promises two
fields when five shipped. Nothing about the backfill, the rollout delay, or the
deferred numeric attributes — all three are things a reader needs. And at four
paragraphs in its original form it dwarfed the notes shipping beside it.

## Draft 2: reader-shaped, but inaccurate

> Users can now use topics, tags, difficulty levels, credentials, and formats to
> refine their search results. Admins can also leverage these attributes to
> personalize and improve search recommendations. Note that updates to tags and
> topics may take anywhere from a few minutes to a few hours to reflect in
> search. A backfill is underway to re-index all existing items, expected to
> take about a week.

Better: leads with capability, covers all five fields, states the backfill. Three
problems remain.

- **"refine"** promises a filter control. There isn't one. The attributes are
  embedded in the index, so natural-language queries match them.
- **"leverage" and "personalize"** — the first is a cut-on-sight word, the second
  claims per-user behavior that doesn't exist here.
- **The latency warning is over-broad.** A single tag edit queues one rebuild and
  lands in minutes. Only bulk operations take hours. As written it tells everyone
  that every edit might take hours, which invites tickets about normal behavior.

## Final

> **Search now reads topics, tags, difficulty, credentials, and formats**
>
> Users can find items by the attributes your team already curates. Asking for
> "an advanced item with a certification," or naming a topic or tag, now returns
> matching results, where before search saw only an item's title, summary,
> description, and body. There's no new setting or filter: the attributes are
> part of what search reads, so ordinary queries match them, and tag names match
> in the item's own language where translations exist. Paths and collections
> inherit the attributes of the items inside them. Adding or removing a tag on
> an item reaches search within minutes; bulk changes like renaming a tag or
> importing a mapping file roll out over a few hours on large catalogs. A
> backfill is re-indexing every existing item and should finish in about a week,
> with no action needed. Duration, rating, and points are not included yet, so a
> request like "short items on onboarding" won't rank by length.

130 words, one paragraph, matching its siblings. If it still runs long for the
format, the deferred-scope sentence is the first cut, then the paths line.

## The lesson

Draft 1 had the right facts in the wrong order at the wrong length. Draft 2 had
the right order and length with the wrong claims. The note needs the PR for
facts, the reader for order, the neighbors for length, and the accuracy-traps
list for the claims.
