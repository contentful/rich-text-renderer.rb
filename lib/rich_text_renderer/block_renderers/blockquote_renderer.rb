require_relative './base_block_renderer'

module RichTextRenderer
  # blockquote node renderer.
  class BlockQuoteRenderer < BaseBlockRenderer
    protected

    def render_tag
      'blockqoute'
    end
  end
end
