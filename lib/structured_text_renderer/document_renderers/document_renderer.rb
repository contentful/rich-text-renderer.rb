require_relative '../base_node_renderer'

module StructuredTextRenderer
  # Document renderer.
  class DocumentRenderer < BaseNodeRenderer
    # Renders all nodes in the document.
    def render(document)
      document['content'].each_with_object([]) do |node, result|
        renderer = find_renderer(node)
        next if renderer.nil?

        result << renderer.render(node)
      end.join("\n")
    end
  end
end
