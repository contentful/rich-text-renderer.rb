require_relative './base_inline_renderer'

module StructuredTextRenderer
  # U node renderer.
  class UnderlineRenderer < BaseInlineRenderer
    protected

    def render_tag
      'u'
    end
  end
end
