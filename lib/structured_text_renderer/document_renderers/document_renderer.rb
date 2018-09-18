module StructuredTextRenderer
  # Document renderer.
  class DocumentRenderer
    attr_reader :mappings

    def initialize(mappings)
      @mappings = mappings
    end

    # Renders all nodes in the document.
    def render(document)
      document['content'].each_with_object([]) do |node, result|
        renderer = mappings[node['nodeType']]
        next if renderer.nil?

        result << renderer.new(mappings).render(node)
      end.join("\n")
    end
  end
end
