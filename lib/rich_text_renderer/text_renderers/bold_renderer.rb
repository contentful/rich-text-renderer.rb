require_relative './base_inline_renderer'

module RichTextRenderer
  # B node renderer.
  class BoldRenderer < BaseInlineRenderer
    protected

    def render_tag
      'b'
    end
  end
end
