require_relative './base_block_renderer'

module RichTextRenderer
  # tr node renderer.
  class TableRowRenderer < BaseBlockRenderer
    protected

    def render_tag
      'tr'
    end
  end
end
