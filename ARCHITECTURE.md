# Architecture

`rich_text_renderer` turns a Contentful `RichText` document into a string. The
default output is HTML, but the renderer is a lookup table from node type to
renderer class, so any node type can be redirected to arbitrary output.

The whole gem is pure computation: no network access, no file IO, no global
state, no runtime dependencies. Output is a function of the node hash plus the
mappings table. That is why the test suite needs no Contentful credentials.

## The document model

A `RichText` field is a JSON tree. Every node carries a `nodeType` string.
Container nodes carry a `content` array of child nodes. Text nodes carry a
`value` string and an optional `marks` array, where each mark is itself a hash
with a `type` (`bold`, `italic`, `code`, `underline`, `superscript`,
`subscript`). Embedded entries and assets carry the referenced object under
`data.target`; hyperlinks carry `data.uri`.

## Rendering pipeline

1. `RichTextRenderer::Renderer.new(mappings)` merges the caller's overrides
   into `DEFAULT_MAPPINGS` (`lib/rich_text_renderer/renderer.rb`) — 28 node
   types plus a `nil` fallback key.
2. `Renderer#render(document)` calls the inherited protected
   `BaseNodeRenderer#find_renderer`, which looks up `node.to_h['nodeType']` in
   the table, instantiates the class **with the full mappings hash**, and calls
   `#render` on it. If no entry matches and a `nil` key exists, the `nil` entry
   is used instead.
3. `DocumentRenderer` (`lib/rich_text_renderer/document_renderers/`) iterates
   `document['content']`, renders each child through the same lookup, and joins
   the results with a newline.
4. `BaseBlockRenderer` emits `<tag>` + rendered children + `</tag>`, where
   `tag` comes from the protected `#render_tag`. `#render_content` recurses back
   through `find_renderer`, which is how nesting works at arbitrary depth.
5. `BaseInlineRenderer` emits `<tag>#{node['value']}</tag>` — inline renderers
   consume a text node's `value` rather than recursing.
6. `TextRenderer` deep-copies the node, escapes `value` with `CGI.escapeHTML`,
   then folds each entry in `marks` over the value, looking each mark's `type`
   up in the same mappings table.

Because every renderer is constructed with the complete mappings hash rather
than with its own local configuration, a single override at the top propagates
to every level of the tree. That is the property the "global mappings" refactor
in 1234a9f was after.

## Layout

| Path | Contents |
| --- | --- |
| `lib/rich_text_renderer.rb` | Public require; pulls in `renderer` and `version` |
| `lib/rich_text_renderer/renderer.rb` | `Renderer` and `DEFAULT_MAPPINGS` |
| `lib/rich_text_renderer/base_node_renderer.rb` | Abstract base; holds `mappings`, provides `find_renderer` |
| `lib/rich_text_renderer/null_renderer.rb` | Catch-all registered under the `nil` key |
| `lib/rich_text_renderer/document_renderers/` | `DocumentRenderer`, the top-level node |
| `lib/rich_text_renderer/block_renderers/` | `BaseBlockRenderer` and 20 block-level renderers |
| `lib/rich_text_renderer/text_renderers/` | `BaseInlineRenderer`, `TextRenderer`, and the mark renderers |
| `lib/rich_text_renderer/version.rb` | `RichTextRenderer::VERSION` |
| `spec/` | Mirrors `lib/` under `spec/lib/`; doubles live in `spec/spec_helper.rb` |

Block renderers cover headings 1-6, `paragraph`, `blockquote`, `hyperlink`,
`hr`, the three list node types, the four table node types, and the three
reference types (`embedded-entry-block`, `embedded-asset-block`,
`asset-hyperlink`).

## Extension points

- **Any node type.** Pass `{'paragraph' => MyRenderer}` to
  `Renderer.new`. The class needs an `initialize(mappings = {})` and a
  `#render(node)` returning a string; subclassing `BaseNodeRenderer` gives you
  both plus `find_renderer` for recursion.
- **Unknown node types.** `NullRenderer` is registered under the `nil` key and
  raises `"No renderer defined for '<type>' nodes"`. Failing loudly is the
  default so that a new Contentful node type does not silently vanish from
  output. Callers who want the opposite behaviour override the `nil` key with a
  renderer that returns `""` — this is documented in `README.md`.
- **Embedded entries.** `EntryBlockRenderer` only wraps
  `node['data']['target'].inspect` in a `<div>`. It exists to be replaced; any
  application rendering embedded entries is expected to override
  `'embedded-entry-block'`.

## Relationship to the Contentful SDK

Asset rendering has to work both for `Contentful::Asset` objects returned by
contentful.rb and for raw JSON hashes from the API. `AssetHyperlinkRenderer`
handles this by checking whether any ancestor class name contains `Asset`, then
falling back to a hash path that validates `fields.file` is present.
`AssetBlockRenderer` subclasses it and overrides both paths to emit `<img>`
when the asset's content type contains `image`. The reason it duck-types rather
than referencing SDK constants is recorded in
[docs/ADRs/2026-08-25-no-runtime-dependency-on-contentful-sdk.md](./docs/ADRs/2026-08-25-no-runtime-dependency-on-contentful-sdk.md).

## Testing approach

Specs are unit tests over single renderers: build the node hash, instantiate
the renderer with whatever slice of the mappings table it needs, assert on the
returned string. `spec/lib/rich_text_renderer/renderer_spec.rb` and
`spec/spec_helper.rb`'s `*MarkdownRenderer` classes cover the override path by
rendering the same document to Markdown instead of HTML.
