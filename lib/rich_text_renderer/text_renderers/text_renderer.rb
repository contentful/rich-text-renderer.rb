require_relative '../base_node_renderer'

module RichTextRenderer
  # Renderer for Text nodes.
  class TextRenderer < BaseNodeRenderer
    # Renders text nodes with all markings.
    def render(node)
      node = Marshal.load(Marshal.dump(node)) # Clone the node

      node.fetch('marks', []).each do |mark|
        renderer = mappings[mark['type']]
        return mappings[nil].new(mappings).render(mark) if renderer.nil? && mappings.key?(nil)
        node['value'] = renderer.new(mappings).render(node) unless renderer.nil?
      end

      node['value']
    end
  end
end
