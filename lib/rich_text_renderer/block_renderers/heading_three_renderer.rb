require_relative './base_block_renderer'

module RichTextRenderer
  # H3 node renderer.
  class HeadingThreeRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h3'
    end
  end
end
