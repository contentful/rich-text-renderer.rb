require_relative './base_block_renderer'

module RichTextRenderer
  # H6 node renderer.
  class HeadingSixRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h6'
    end
  end
end
