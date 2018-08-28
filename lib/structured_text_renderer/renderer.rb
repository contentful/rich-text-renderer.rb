require_relative './text_renderers'
require_relative './block_renderers'
require_relative './document_renderers'

# StructuredTextRenderer Namespace
module StructuredTextRenderer
  # Renderer for StructuredText field from Contentful
  class Renderer
    # Default Renderers
    DEFAULT_CONFIG = {
      document_renderer: DocumentRenderer,
      heading_one_renderer: HeadingOneRenderer,
      heading_two_renderer: HeadingTwoRenderer,
      entry_block_renderer: EntryBlockRenderer,
      paragraph_renderer: ParagraphRenderer,
      text_renderer: TextRenderer,
      bold_renderer: BoldRenderer,
      italic_renderer: ItalicRenderer,
      underline_renderer: UnderlineRenderer
    }

    attr_reader :config, :document_renderer

    def initialize(config = {})
      @config = DEFAULT_CONFIG.merge(config)

      @bold_renderer = @config[:bold_renderer].new
      @italic_renderer = @config[:italic_renderer].new
      @underline_renderer = @config[:underline_renderer].new

      @text_renderer = @config[:text_renderer].new(
        bold_renderer: @bold_renderer,
        italic_renderer: @italic_renderer,
        underline_renderer: @underline_renderer
      )

      @heading_one_renderer = @config[:heading_one_renderer].new(
        text_renderer: @text_renderer
      )
      @heading_two_renderer = @config[:heading_two_renderer].new(
        text_renderer: @text_renderer
      )
      @paragraph_renderer = @config[:paragraph_renderer].new(
        text_renderer: @text_renderer
      )
      @entry_block_renderer = @config[:entry_block_renderer].new

      @document_renderer = @config[:document_renderer].new(
        heading_one_renderer: @heading_one_renderer,
        heading_two_renderer: @heading_two_renderer,
        paragraph_renderer: @paragraph_renderer,
        entry_block_renderer: @entry_block_renderer
      )
    end

    # Returns a rendered StructuredText document
    def render(document)
      document_renderer.render(document)
    end
  end
end
