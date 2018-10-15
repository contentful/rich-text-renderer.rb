require_relative '../base_node_renderer'

module RichTextRenderer
  # Base renderer for inline nodes.
  class BaseInlineRenderer < BaseNodeRenderer
    # Renders inline nodes.
    def render(node)
      "<#{render_tag}>#{node['value']}</#{render_tag}>"
    end

    protected

    def render_tag
      'span'
    end
  end
end
