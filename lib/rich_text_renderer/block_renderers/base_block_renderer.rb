require_relative '../base_node_renderer'

module RichTextRenderer
  # Base renderer for block type nodes
  class BaseBlockRenderer < BaseNodeRenderer
    # Renders block type nodes.
    def render(node)
      "<#{render_tag}>#{render_content(node)}</#{render_tag}>"
    end

    protected

    def render_content(node)
      node['content'].each_with_object([]) do |content_node, result|
        renderer = find_renderer(content_node)
        result << renderer.render(content_node)
      end.join
    end

    def render_tag
      'div'
    end
  end
end
