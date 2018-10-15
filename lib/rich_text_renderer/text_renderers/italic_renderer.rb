require_relative './base_inline_renderer'

module RichTextRenderer
  # I node renderer.
  class ItalicRenderer < BaseInlineRenderer
    protected

    def render_tag
      'i'
    end
  end
end
