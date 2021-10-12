require_relative './base_block_renderer'

module RichTextRenderer
  # table node renderer.
  class TableRenderer < BaseBlockRenderer
    def render_tag
      'table'
    end
  end
end
