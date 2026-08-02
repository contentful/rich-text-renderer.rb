# Global Mappings Architecture

## Status

Accepted

## Context

The initial implementation (commit `577d057`, 2018-08-28) used a different internal architecture for dispatching node types to renderer classes. Within days of the initial commit, the architecture was revisited in PR #2 ("Change architecture to global mappings", commit `1234a9f`, 2018-09-18).

The renderer needed a flexible, overridable mapping from RichText node type strings to renderer classes, so that consumers could customize rendering for any node type (most critically `embedded-entry-block`, which is always application-specific).

## Decision

Node-type-to-renderer dispatch is driven by a single `DEFAULT_MAPPINGS` hash on the `Renderer` class. At initialization, consumers merge their custom mappings over the defaults:

```ruby
def initialize(mappings = {})
  @mappings = DEFAULT_MAPPINGS.merge(mappings)
end
```

The `nil` key in `DEFAULT_MAPPINGS` is the catch-all for unmapped node types, pointing to `NullRenderer`. All renderers receive the full `mappings` hash at initialization, enabling recursive rendering through the node tree.

## Consequences

- Consumers can override any single node type without affecting others — the merge strategy gives full granularity.
- Adding support for a new Contentful node type requires one new renderer class and one new entry in `DEFAULT_MAPPINGS`.
- The `nil` key pattern is non-obvious — first-time readers should know that overriding `nil` silences errors for unknown types.
- All renderer classes receive the full `mappings` hash, which enables child nodes to be rendered by the same renderer registry (recursive dispatch).
