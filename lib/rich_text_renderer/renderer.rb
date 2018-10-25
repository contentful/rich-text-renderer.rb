require_relative './text_renderers'
require_relative './block_renderers'
require_relative './document_renderers'
require_relative './base_node_renderer'
require_relative './null_renderer'

# RichTextRenderer Namespace
module RichTextRenderer
  # Renderer for RichText field from Contentful
  class Renderer < BaseNodeRenderer
    # Default Renderers
    DEFAULT_MAPPINGS = {
      nil => NullRenderer,
      'document' => DocumentRenderer,
      'heading-1' => HeadingOneRenderer,
      'heading-2' => HeadingTwoRenderer,
      'heading-3' => HeadingThreeRenderer,
      'heading-4' => HeadingFourRenderer,
      'heading-5' => HeadingFiveRenderer,
      'heading-6' => HeadingSixRenderer,
      'blockquote' => BlockQuoteRenderer,
      'hyperlink' => HyperlinkRenderer,
      'paragraph' => ParagraphRenderer,
      'list-item' => ListItemRenderer,
      'ordered-list' => OrderedListRenderer,
      'unordered-list' => UnorderedListRenderer,
      'embedded-entry-block' => EntryBlockRenderer,
      'embedded-asset-block' => AssetBlockRenderer,
      'asset-hyperlink' => AssetHyperlinkRenderer,
      'hr' => HrRenderer,
      'text' => TextRenderer,
      'bold' => BoldRenderer,
      'code' => CodeRenderer,
      'italic' => ItalicRenderer,
      'underline' => UnderlineRenderer
    }

    def initialize(mappings = {})
      @mappings = DEFAULT_MAPPINGS.merge(mappings)
    end

    # Returns a rendered RichText document
    def render(document)
      renderer = find_renderer(document)
      renderer.render(document) unless renderer.nil?
    end
  end
end
