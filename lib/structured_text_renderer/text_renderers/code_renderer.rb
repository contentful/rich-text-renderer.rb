require_relative './base_inline_renderer'

module StructuredTextRenderer
  # code node renderer.
  class CodeRenderer < BaseInlineRenderer
    protected

    def render_tag
      'code'
    end
  end
end
