require_relative './text_renderers'
require_relative './block_renderers'
require_relative './document_renderers'
require_relative './base_node_renderer'
require_relative './null_renderer'

# StructuredTextRenderer Namespace
module StructuredTextRenderer
  # Renderer for StructuredText field from Contentful
  class Renderer < BaseNodeRenderer
    # Default Renderers
    DEFAULT_MAPPINGS = {
      'document' => DocumentRenderer,
      'heading-1' => HeadingOneRenderer,
      'heading-2' => HeadingTwoRenderer,
      'heading-3' => HeadingThreeRenderer,
      'heading-4' => HeadingFourRenderer,
      'heading-5' => HeadingFiveRenderer,
      'heading-6' => HeadingSixRenderer,
      'embedded-entry-block' => EntryBlockRenderer,
      'paragraph' => ParagraphRenderer,
      'ordered-list' => OrderedListRenderer,
      'unordered-list' => UnorderedListRenderer,
      'list-item' => ListItemRenderer,
      'hr' => HrRenderer,
      'text' => TextRenderer,
      'bold' => BoldRenderer,
      'italic' => ItalicRenderer,
      'underline' => UnderlineRenderer,
      'code' => CodeRenderer,
      nil => NullRenderer
    }

    def initialize(mappings = {})
      @mappings = DEFAULT_MAPPINGS.merge(mappings)
    end

    # Returns a rendered StructuredText document
    def render(document)
      renderer = find_renderer(document)
      renderer.render(document) unless renderer.nil?
    end
  end
end
