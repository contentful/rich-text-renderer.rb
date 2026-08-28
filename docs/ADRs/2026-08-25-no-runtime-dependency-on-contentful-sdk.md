# No runtime dependency on the Contentful Delivery SDK

- **Date:** 2026-08-25
- **Status:** Accepted (in effect since 2018-10-26)

> This record was written on 2026-08-25 from the repository's commit history and
> source. It documents an existing decision rather than a new one; the rationale
> below is reconstructed from the code and commit contents cited, not from a
> contemporaneous discussion.

## Context

`rich_text_renderer` renders Contentful `RichText` documents. Most nodes are
plain hashes and need nothing external. Assets are the exception: an
`embedded-asset-block` or `asset-hyperlink` node carries the referenced asset
under `data.target`, and the renderer needs the asset's URL, title and content
type to emit an `<a>` or an `<img>`.

Where that asset object comes from depends on the caller. A caller using the
[Contentful Delivery SDK](https://github.com/contentful/contentful.rb) has a
`Contentful::Asset` with `#url`, `#title` and `#file.content_type`. A caller
that fetched the CDA response itself, or that uses a different client, has a
raw hash with `fields.file.url`, `fields.title` and `fields.file.contentType`.

Asset support was added in `d01908d` ("Add Asset support (#6)",
2018-10-26). Reading SDK attributes off a typed object would have been the
shortest path, but it would have made contentful.rb a hard requirement of a
gem whose only other need is `CGI`.

## Decision

The gem declares **no runtime dependencies**, and asset handling detects the
shape of `data.target` at render time instead of referencing SDK constants.

`rich_text_renderer.gemspec` contains only `add_development_dependency` calls —
bundler, rake, rubygems-tasks, guard and its plugins, yard, rubocop, rspec,
simplecov. There is no `add_runtime_dependency` and no `add_dependency`.

`lib/rich_text_renderer/block_renderers/asset_hyperlink_renderer.rb` implements
the detection, and carries the intent as a comment in the source:

```ruby
# Check by class name instead of instance type to
# avoid dependending on the Contentful SDK.
return render_asset(asset, node) if asset.class.ancestors.map(&:to_s).any? { |name| name.include?('Asset') }
```

If that check fails and the target is a `Hash` containing `fields.file`, the
`render_hash` path runs instead; anything else fails with
`"Node target is not an asset"`. `AssetBlockRenderer` extends the same pair of
hooks — `render_asset` and `render_hash` — to emit `<img>` for image content
types. The two-path structure is therefore load-bearing, not accidental
duplication.

The test suite follows from the same decision: `spec/spec_helper.rb` defines
local `MockAsset` and `MockFile` classes rather than depending on the SDK's
types.

## Consequences

- The gem installs and its suite runs with no Contentful gem present and no
  credentials. The `test_and_lint` job in `.circleci/config.yml` does nothing
  but `gem install bundler:2.3.26`, `bundle install` and
  `bundle exec rake rspec_rubocop`.
- Renderers work unchanged for callers who bypass contentful.rb, and the gem
  cannot pin users to a particular SDK major version.
- Asset detection is a string match on ancestor class names. Any class whose
  name or an ancestor's name contains `Asset` takes the SDK path and is
  expected to respond to `#url`, `#title` and `#file`. A false positive
  surfaces as a `NoMethodError` rather than a clear error message.
- The contract with the SDK is implicit. If contentful.rb renames `Asset` or
  changes `#file.content_type`, nothing in this repository fails at load time —
  it breaks at render time, and no dependency bump signals it in advance.
- Adding a runtime dependency later is a breaking change in spirit for this
  gem's consumers, so new features should keep to the standard library or
  duck-type in the same way.
