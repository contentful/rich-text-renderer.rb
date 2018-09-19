require_relative './base_block_renderer'

module StructuredTextRenderer
  # H4 node renderer.
  class HeadingFourRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h4'
    end
  end
end
