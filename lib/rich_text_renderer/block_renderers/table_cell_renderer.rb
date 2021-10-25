require_relative './base_block_renderer'

module RichTextRenderer
  # td node renderer.
  class TableCellRenderer < BaseBlockRenderer
    protected

    def render_tag
      'td'
    end
  end
end
