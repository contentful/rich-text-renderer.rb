require_relative './base_block_renderer'

module RichTextRenderer
  # table node renderer.
  class TableRenderer < BaseBlockRenderer
    def render(node)
      "<table>#{render_content(node)}</table>"
    end
  end
end
