require_relative './base_node_renderer'

module RichTextRenderer
  # Catch-all renderer for missing node types
  class NullRenderer < BaseNodeRenderer
    # Will raise an exception indicating the missing node type.
    def render(node)
      fail "No renderer defined for '#{node_type(node)}' nodes"
    end

    private

    def node_type(node)
      return node['nodeType'] if node.key?('nodeType')
      return node['type'] if node.key?('type')
      node
    end
  end
end
