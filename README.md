# Contentful Rich Text Renderer

[Contentful](https://www.contentful.com) provides a content infrastructure for digital teams to power content in websites, apps, and devices. Unlike a CMS, Contentful was built to integrate with the modern software stack. It offers a central hub for structured content, powerful management and delivery APIs, and a customizable web app that enable developers and content creators to ship digital products faster.

This library provides rendering capabilities for the `RichText` field type. It is recommended to be used alongside the [Contentful Delivery SDK](https://www.github.com/contentful/contentful.rb).
By default this library will serialize `RichText` fields into it's corresponding HTML representation. All behaviour can be overridden to serialize to different formats.

## Installation

Install Contentful Rich Text Renderer from RubyGems:

```bash
gem install rich_text_renderer
```

## Usage

Create a renderer:

```ruby
require 'rich_text_renderer'

renderer = RichTextRenderer::Renderer.new
```

Render your document:

```ruby
renderer.render(document)
```

## Using different renderers

There are many cases in which HTML serialization is not what you want.
Therefore, all renderers are overridable when creating a `RichTextRenderer`.

Also, if you're planning to embed entries within your rich text, overriding the `'embedded-entry-block'` mapping is a must,
as by default it only does `<div>#{entry.to_s}</div>`.

You can override the configuration like follows:

```ruby
renderer = RichTextRenderer::Renderer.new(
  'embedded-entry-block' => MyEntryBlockRenderer
)
```

Where `MyEntryBlockRenderer` requires to have a `#render(node)` method and needs to return a string.

An example entry renderer, assuming our entry has 2 fields called `name` and `description` could be:

```ruby
class MyEntryBlockRenderer < RichTextRenderer::BaseNodeRenderer
  def render(node)
    entry = node['data']['target']

    "<div class='my-entry'><h3>#{entry.name}</h3><p><small>#{entry.description}</p></small></div>"
  end
end
```

## Dealing with unknown node types

By default, this gem will treat all unknown node types as errors and will raise an exception letting the user know which node mapping is missing.
If you wish to remove this behaviour then replace the `nil` key of the mapping with a NullRenderer that returns an empty string, or something similar.

An example would be like follows:

```ruby
class SilentNullRenderer < RichTextRenderer::BaseNodeRenderer
  def render(node)
    ""
  end
end

renderer = RichTextRenderer::Renderer.new(
  nil => SilentNullRenderer
)
```

## License

Copyright (c) 2018 Contentful GmbH. See [LICENSE](./LICENSE) for further details.

## Contributing

Feel free to improve this tool by submitting a Pull Request.
