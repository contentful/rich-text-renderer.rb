# SDK-Agnostic Asset Rendering via Duck Typing

## Status

Accepted

## Context

When `embedded-asset-block` and `asset-hyperlink` nodes were added (PR #6, commit `d01908d`, 2018-10-26), asset rendering needed to handle the target object in the node's `data.target`. This target could be:

1. A `Contentful::Asset` object from the `contentful.rb` SDK
2. A raw Ruby Hash (for consumers who parse the API JSON themselves without the SDK)

An `is_a?(Contentful::Asset)` check would introduce a hard runtime dependency on the `contentful.rb` gem — making `rich-text-renderer.rb` unusable without it, despite the gem being intentionally SDK-agnostic.

## Decision

`AssetHyperlinkRenderer#render` detects asset SDK objects using ancestor-chain inspection rather than `is_a?`:

```ruby
asset.class.ancestors.map(&:to_s).any? { |name| name.include?('Asset') }
```

If this check fails, it falls back to checking `is_a?(::Hash)` and inspecting the expected hash structure. If neither matches, it raises a descriptive error.

## Consequences

- The gem works with `contentful.rb` SDK objects and with raw Hash representations without requiring either.
- The duck typing check is broad — any class with "Asset" in its ancestor chain will be treated as an SDK asset. This is intentional and matches the Contentful SDK naming convention.
- Consumers using non-standard asset representations will get an explicit error rather than silent failure.
- `AssetBlockRenderer` inherits from `AssetHyperlinkRenderer`, reusing this detection logic and adding image rendering via content type inspection.
