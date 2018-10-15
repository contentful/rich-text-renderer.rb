require_relative './base_block_renderer'

module RichTextRenderer
  # ul node renderer.
  class UnorderedListRenderer < BaseBlockRenderer
    protected

    def render_tag
      'ul'
    end
  end
end
