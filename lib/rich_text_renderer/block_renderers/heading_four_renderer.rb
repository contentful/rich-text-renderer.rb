require_relative './base_block_renderer'

module RichTextRenderer
  # H4 node renderer.
  class HeadingFourRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h4'
    end
  end
end
