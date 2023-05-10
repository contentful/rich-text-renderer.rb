# frozen_string_literal: true

require_relative './base_inline_renderer'

module RichTextRenderer
  # superscript node renderer.
  class SuperscriptRenderer < BaseInlineRenderer
    protected

    def render_tag
      'sup'
    end
  end
end
