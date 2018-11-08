require_relative '../base_node_renderer'

module RichTextRenderer
  # Default embedded entry renderer.
  # Dumps entry to string.
  # This renderer should be overridden for your particular applications.
  class EntryBlockRenderer < BaseNodeRenderer
    # Renders embedded entry node.
    def render(node)
      "<div>#{node['data']['target']}</div>"
    end
  end
end
