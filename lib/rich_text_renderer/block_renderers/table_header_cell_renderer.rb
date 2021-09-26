require_relative './base_block_renderer'

module RichTextRenderer
  # th node renderer.
  class TableHeaderCellRenderer < BaseBlockRenderer
    protected

    def render_tag
      'th'
    end
  end
end
