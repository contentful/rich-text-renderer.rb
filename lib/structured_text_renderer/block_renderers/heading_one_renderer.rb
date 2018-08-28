require_relative './base_block_renderer'

module StructuredTextRenderer
  # H1 node renderer.
  class HeadingOneRenderer < BaseBlockRenderer
    protected

    def render_tag
      'h1'
    end
  end
end
