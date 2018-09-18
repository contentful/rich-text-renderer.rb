module StructuredTextRenderer
  # Renderer for Text nodes.
  class TextRenderer
    attr_reader :mappings

    def initialize(mappings = {})
      @mappings = mappings
    end

    # Renders text nodes with all markings.
    def render(node)
      node = Marshal.load(Marshal.dump(node))

      node.fetch('marks', []).each do |mark|
        renderer = mappings[mark['type']]
        node['value'] = renderer.new(mappings).render(node) unless renderer.nil?
      end

      node['value']
    end
  end
end
