require_relative './text_renderers'
require_relative './block_renderers'
require_relative './document_renderers'

# StructuredTextRenderer Namespace
module StructuredTextRenderer
  # Renderer for StructuredText field from Contentful
  class Renderer
    # Default Renderers
    DEFAULT_MAPPINGS = {
      'document' => DocumentRenderer,
      'heading-1' => HeadingOneRenderer,
      'heading-2' => HeadingTwoRenderer,
      'embedded-entry-block' => EntryBlockRenderer,
      'paragraph' => ParagraphRenderer,
      'text' => TextRenderer,
      'bold' => BoldRenderer,
      'italic' => ItalicRenderer,
      'underline' => UnderlineRenderer
    }

    attr_reader :mappings, :document_renderer

    def initialize(mappings = {})
      @mappings = DEFAULT_MAPPINGS.merge(mappings)
    end

    # Returns a rendered StructuredText document
    def render(document)
      renderer = mappings[document['nodeType']]
      renderer.new(mappings).render(document) unless renderer.nil?
    end
  end
end
