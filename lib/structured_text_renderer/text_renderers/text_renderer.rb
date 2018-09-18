require_relative '../base_node_renderer'

module StructuredTextRenderer
  # Renderer for Text nodes.
  class TextRenderer < BaseNodeRenderer
    # Renders text nodes with all markings.
    def render(node)
      node = Marshal.load(Marshal.dump(node)) # Clone the node

      node.fetch('marks', []).each do |mark|
        renderer = mappings[mark['type']]
        node['value'] = renderer.new(mappings).render(node) unless renderer.nil?
      end

      node['value']
    end
  end
end
