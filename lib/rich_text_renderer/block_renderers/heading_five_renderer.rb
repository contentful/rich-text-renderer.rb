require_relative './base_block_renderer'

module RichTextRenderer
  # H5 node renderer.
  class HeadingFiveRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h5'
    end
  end
end
