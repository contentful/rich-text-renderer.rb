require_relative '../base_node_renderer'

module RichTextRenderer
  # Document renderer.
  class DocumentRenderer < BaseNodeRenderer
    # Renders all nodes in the document.
    def render(document)
      document['content'].each_with_object([]) do |node, result|
        result << find_renderer(node).render(node)
      end.join("\n")
    end
  end
end
