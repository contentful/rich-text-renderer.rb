module StructuredTextRenderer
  # Base class for all NodeRenderers
  class BaseNodeRenderer
    attr_reader :mappings

    def initialize(mappings = {})
      @mappings = mappings
    end

    protected

    def find_renderer(node)
      renderer = mappings[node['nodeType']]
      return if renderer.nil?
      renderer.new(mappings)
    end
  end
end
