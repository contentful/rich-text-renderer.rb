# frozen_string_literal: true

require_relative './base_inline_renderer'

module RichTextRenderer
  # subscript node renderer.
  class SubscriptRenderer < BaseInlineRenderer
    protected

    def render_tag
      'sub'
    end
  end
end
