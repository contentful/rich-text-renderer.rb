# Contributing

Contributions are welcome — as `README.md` puts it, feel free to improve this
tool by submitting a Pull Request. This file records how to do that so CI
passes on the first try.

## Getting set up

You need a Ruby that CI also covers: 3.2, 3.3 or 3.4, per the matrix in
`.circleci/config.yml`. Then:

```bash
git clone https://github.com/contentful/rich-text-renderer.rb.git
cd rich-text-renderer.rb
bundle install
```

`Gemfile.lock` is intentionally gitignored, so the resolve is fresh each time.
Nothing here needs Contentful credentials or network access at test time.

## Running things

```bash
bundle exec rspec                  # the suite
bundle exec rubocop                # lint
bundle exec rake rspec_rubocop     # both, in the order CI runs them
bundle exec guard                  # watch mode while you work
```

`bundle exec rake rspec_rubocop` is the command CI runs. If it is green
locally on one of the supported Rubies, CI is very likely green too.

## Making a change

The default branch is `master`. Branch from it, and open the Pull Request
against it.

Adding support for a new node type takes four edits:

1. A renderer class in `lib/rich_text_renderer/block_renderers/` or
   `lib/rich_text_renderer/text_renderers/`, subclassing `BaseBlockRenderer`,
   `BaseInlineRenderer` or `BaseNodeRenderer`. If the only difference from the
   base is the HTML tag, override the protected `#render_tag` and nothing else.
2. A `require_relative` line in the matching aggregator —
   `lib/rich_text_renderer/block_renderers.rb` or
   `lib/rich_text_renderer/text_renderers.rb`. Loading is explicit; a file that
   is not required is not loaded.
3. An entry in `DEFAULT_MAPPINGS` in `lib/rich_text_renderer/renderer.rb`, keyed
   by the Contentful `nodeType` string exactly as it appears in the API
   response.
4. A spec at the mirrored path under `spec/lib/`, named `*_spec.rb`. The suffix
   matters — RSpec's default pattern is what discovers the file.

`e4af1c1` (superscript and subscript) is a good example of the full shape of
such a change.

## Style

RuboCop is enforced in CI, so run it. `.rubocop.yml` inherits
`.rubocop_todo.yml`; the todo file is generated output, so prefer fixing an
offence over adding an exclusion. Two things that surprise people:

- `Style/SignalException` is set to `only_fail`. Raise with `fail`, not `raise`.
- `spec/**/*`, `Gemfile`, `Rakefile` and `Guardfile` are excluded from linting
  entirely.

Otherwise, follow what the surrounding files already do: two-space indent,
`require_relative` for internal requires, one class per file, a short comment
above each class (YARD is configured with `--no-private` in `.yardopts`).

## Changelog

`CHANGELOG.md` is maintained by hand and has an `## Unreleased` heading at the
top. Add your entry there as part of the same Pull Request. Do not bump
`lib/rich_text_renderer/version.rb` — that happens at release time.

## Review and merge

`.github/CODEOWNERS` routes every path to `@contentful/team-developer-experience`,
so a review from that team is required. CI must be green. Squash or merge as the
reviewer prefers; the history contains both styles.

## Releasing

Maintainers only, and manual:

1. Bump `VERSION` in `lib/rich_text_renderer/version.rb`.
2. Move the `## Unreleased` entries in `CHANGELOG.md` under the new version
   heading.
3. Commit (the history uses `Bump to version X.Y.Z`, e.g. 0300473).
4. Publish with the tasks `rubygems-tasks` registers via `Gem::Tasks.new` in
   the `Rakefile` — `rake build` and `rake release`. Tags are `v`-prefixed,
   e.g. `v0.3.3`.

There is no CI publish job; nothing is released by merging to `master`.

## Reporting problems

Open a GitHub issue on
[contentful/rich-text-renderer.rb](https://github.com/contentful/rich-text-renderer.rb/issues).
A minimal `RichText` document hash that reproduces the wrong output is the most
useful thing you can include, since every renderer is a pure function of that
hash.
