require_relative './base_block_renderer'

module StructuredTextRenderer
  # P node renderer.
  class ParagraphRenderer < BaseBlockRenderer
    protected

    def render_tag
      'p'
    end
  end
end
