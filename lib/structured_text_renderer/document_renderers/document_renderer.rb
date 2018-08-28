module StructuredTextRenderer
  # Document renderer.
  class DocumentRenderer
    attr_reader :mappings

    def initialize(config = {})
      @mappings = {
        'heading-1' => config[:heading_one_renderer],
        'heading-2' => config[:heading_two_renderer],
        'paragraph' => config[:paragraph_renderer],
        'embedded-entry-block' => config[:entry_block_renderer]
      }
    end

    # Renders all nodes in the document.
    def render(document)
      document['content'].each_with_object([]) do |node, result|
        renderer = mappings[node['nodeType']]
        next if renderer.nil?

        result << renderer.render(node)
      end.join("\n")
    end
  end
end
