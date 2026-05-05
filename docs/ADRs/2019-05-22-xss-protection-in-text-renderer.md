# XSS Protection in TextRenderer

## Status

Accepted

## Context

RichText fields can contain arbitrary user-authored text. When rendered to HTML, unescaped text values create an XSS vector — if a content author (or an attacker who can write content) embeds `<script>` tags or event handlers in a text node, they would execute in the consumer's rendered HTML.

PR #10 (commit `64589fa`, 2019-05-22, "Escape text nodes") addressed this. The companion PR #9 also fixed a misspelled blockquote tag in the same release cycle.

## Decision

`TextRenderer#render` HTML-escapes the raw `value` string via `CGI.escapeHTML` before applying any inline mark renderers:

```ruby
node['value'] = CGI.escapeHTML(node['value'])
```

Escaping happens before marks are applied so that bold, italic, etc. wrap the already-safe text.

The node is deep-cloned via `Marshal.load(Marshal.dump(node))` before mutation to avoid modifying the caller's document object.

## Consequences

- The gem is safe for rendering user-authored RichText to HTML by default.
- Consumers who need raw unescaped output (e.g., for non-HTML targets) must override `TextRenderer` to skip the escaping step.
- The `Marshal` deep-clone is a deliberate defensive pattern — removing it would cause mutation bugs if the caller reuses the same document hash.
- `CGI` is a Ruby stdlib module — no new dependency required.
