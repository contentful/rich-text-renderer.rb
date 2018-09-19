require_relative './base_block_renderer'

module StructuredTextRenderer
  # blockquote node renderer.
  class QuoteRenderer < BaseBlockRenderer
    protected

    def render_tag
      'blockqoute'
    end
  end
end
