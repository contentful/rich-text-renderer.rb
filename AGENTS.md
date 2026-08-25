# AGENTS.md

Orientation for coding agents and new contributors working in
`contentful/rich-text-renderer.rb`.

## What this repository is

The `rich_text_renderer` gem. It serializes a Contentful `RichText` field
document — a nested Ruby hash decoded from JSON — into HTML, and every part of
that serialization is overridable. It is meant to be used alongside the
[Contentful Delivery SDK](https://github.com/contentful/contentful.rb) but does
not depend on it: `rich_text_renderer.gemspec` declares development
dependencies only, no runtime dependencies.

Public entry point is `lib/rich_text_renderer.rb`, which requires
`lib/rich_text_renderer/renderer.rb` and `lib/rich_text_renderer/version.rb`.
The only class most callers touch is `RichTextRenderer::Renderer`. See
[ARCHITECTURE.md](./ARCHITECTURE.md) for the rendering pipeline.

## Commands

```bash
bundle install
bundle exec rspec                  # run the suite
bundle exec rubocop                # lint
bundle exec rake rspec_rubocop     # both, exactly what CI runs
bundle exec rake                   # defaults to :spec
bundle exec guard                  # watch mode: rspec, yard, rubocop
bundle exec yard doc               # generate documentation
```

`.rspec` passes `--color --format documentation`. `.yardopts` passes
`--no-private` and includes `CHANGELOG.md` and `LICENSE.txt`.

No credentials are needed to run anything in this repository. There is no
network access and no fixture download step — specs build their input hashes
inline and use the hand-rolled `MockAsset` / `MockFile` doubles in
`spec/spec_helper.rb`.

## CI

`.circleci/config.yml` defines one job, `test_and_lint`, run as a matrix over
Ruby `3.2`, `3.3` and `3.4` on the `cimg/ruby:<version>` images. Each run does
`gem install bundler:2.3.26`, `bundle install`, then
`bundle exec rake rspec_rubocop`. There is no publish job.

`.github/workflows/codeql.yml` runs CodeQL, but only over
`.github/workflows/**` — it analyses the workflow definitions, not the Ruby
source.

## Conventions

- Every renderer subclasses `RichTextRenderer::BaseNodeRenderer` and exposes
  `#render(node)` returning a `String`.
- Most block and inline renderers override nothing but the protected
  `#render_tag`. Prefer that over reimplementing `#render`. See
  `lib/rich_text_renderer/block_renderers/paragraph_renderer.rb` for the
  minimal shape.
- Loading is explicit `require_relative`, no autoloading. A new renderer must
  be added in three places: its own file, the matching aggregator
  (`lib/rich_text_renderer/block_renderers.rb`,
  `lib/rich_text_renderer/text_renderers.rb`, or
  `lib/rich_text_renderer/document_renderers.rb`), and `DEFAULT_MAPPINGS` in
  `lib/rich_text_renderer/renderer.rb`, keyed by the Contentful `nodeType`
  string.
- `.rubocop.yml` inherits `.rubocop_todo.yml`, which was generated 2024-04-01
  with RuboCop 1.62.1. `Style/SignalException` is set to `only_fail`, so raise
  errors with `fail`, not `raise`. `spec/**/*`, `Gemfile`, `Rakefile` and
  `Guardfile` are excluded from linting.
- Specs mirror `lib/` under `spec/lib/`, one `*_spec.rb` per renderer.
- `CHANGELOG.md` is hand-maintained and has an `## Unreleased` heading at the
  top. Add entries there.

## Gotchas

- The default branch is `master`, not `main`.
- `spec/lib/rich_text_renderer/text_renderers/subscript_renderer.rb` is a spec
  file that is missing the `_spec` suffix, so neither `bundle exec rspec` nor
  the Rake task loads it. It arrived that way in e4af1c1. Renaming it may
  surface assertions that have never actually run.
- `.rubocop.yml` still excludes `structured_text_renderer.gemspec`, a filename
  that has not existed since the rename in 97c6913. It is inert, not a live
  rule.
- `README.md` links to `./LICENSE`; the file on disk is `LICENSE.txt`.
- `TextRenderer` deep-copies its node with `Marshal.load(Marshal.dump(node))`
  before mutating `value`. That is deliberate — callers own the document they
  pass in.
- `AssetHyperlinkRenderer` identifies assets by scanning `class.ancestors` for
  a name containing `Asset` rather than by class equality, and handles raw
  hashes on a separate code path. The reasoning is recorded in
  [docs/ADRs](./docs/ADRs/).

## Release

Manual, with no automation. Bump `VERSION` in
`lib/rich_text_renderer/version.rb`, move the `## Unreleased` entries in
`CHANGELOG.md` under the new version heading, commit, then use the tasks that
`rubygems-tasks` registers through `Gem::Tasks.new` in the `Rakefile`
(`rake build`, `rake release`). The history shows this as explicit
"Bump to version X" commits — 0300473 for 0.3.3, 465846a for 0.3.2 — and
`v`-prefixed tags such as `v0.3.3`.

## Ownership

`.github/CODEOWNERS` and `catalog-info.yaml` both assign this repository to
`team-developer-experience`. It is a tier-4 library; CI alerts go to the
`sdk-bots` Slack channel. Dependency bumps arrive from Renovate, configured in
`renovate.json` extending `local>contentful/renovate-config` (set up in
b40e79b).
