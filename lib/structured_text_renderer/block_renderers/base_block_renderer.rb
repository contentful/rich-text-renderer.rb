require_relative '../base_node_renderer'

module StructuredTextRenderer
  # Base renderer for block type nodes
  class BaseBlockRenderer < BaseNodeRenderer
    # Renders block type nodes.
    def render(node)
      node['content'].each_with_object([]) do |content_node, result|
        renderer = find_renderer(content_node)
        next if renderer.nil?
        result << "<#{render_tag}>#{renderer.render(content_node)}</#{render_tag}>"
      end.join("\n")
    end

    protected

    def render_tag
      'div'
    end
  end
end
