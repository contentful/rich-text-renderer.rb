require_relative './base_block_renderer'

module StructuredTextRenderer
  # ol node renderer.
  class OrderedListRenderer < BaseBlockRenderer
    protected

    def render_tag
      'ol'
    end
  end
end
