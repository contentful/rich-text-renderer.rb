require_relative './base_block_renderer'

module RichTextRenderer
  # H1 node renderer.
  class HeadingOneRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h1'
    end
  end
end
