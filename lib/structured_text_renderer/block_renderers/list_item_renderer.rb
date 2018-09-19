require_relative './base_block_renderer'

module StructuredTextRenderer
  # li node renderer.
  class ListItemRenderer < BaseBlockRenderer
    protected

    def render_tag
      'li'
    end
  end
end
