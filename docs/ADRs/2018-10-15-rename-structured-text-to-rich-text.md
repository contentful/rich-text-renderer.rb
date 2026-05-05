# Rename StructuredText to RichText

## Status

Accepted

## Context

Contentful's rich text field type was originally called `StructuredText` during its alpha period. As the feature moved from alpha to beta (v0.1.0), Contentful renamed the product concept to `RichText` across all SDKs and APIs. This required renaming the gem and its Ruby namespacing accordingly.

The original gem was named `structured_text_renderer` and used a `StructuredTextRenderer` namespace. PR #5 (commit `97c6913`, 2018-10-15) performed the rename.

## Decision

The gem was renamed from `structured_text_renderer` to `rich_text_renderer`, and the Ruby namespace was changed from `StructuredTextRenderer` to `RichTextRenderer`. The version was bumped to `0.1.0` to signal the breaking rename. The old gem name (`structured_text_renderer`) is implicitly abandoned.

## Consequences

- Any consumer using `0.0.x` versions must update both the gem name and namespace references.
- The gem name `rich_text_renderer` on RubyGems reflects the current product terminology.
- All subsequent development targets the `rich_text_renderer` gem name and `RichTextRenderer` namespace.
