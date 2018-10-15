module RichTextRenderer
  # Base class for all NodeRenderers
  class BaseNodeRenderer
    attr_reader :mappings

    def initialize(mappings = {})
      @mappings = mappings
    end

    protected

    def find_renderer(node)
      renderer = mappings[node['nodeType']]
      return mappings[nil].new(mappings) if renderer.nil? && mappings.key?(nil)
      renderer.new(mappings) unless renderer.nil?
    end
  end
end
