require_relative './base_block_renderer'

module RichTextRenderer
  # H2 node renderer.
  class HeadingTwoRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h2'
    end
  end
end
