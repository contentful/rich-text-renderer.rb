module StructuredTextRenderer
  # Base renderer for block type nodes
  class BaseBlockRenderer
    attr_reader :mappings

    def initialize(mappings)
      @mappings = mappings
    end

    # Renders block type nodes.
    def render(node)
      node['content'].each_with_object([]) do |content, result|
        renderer = mappings[content['nodeType']]
        next if renderer.nil?
        result << "<#{render_tag}>#{renderer.new(mappings).render(content)}</#{render_tag}>"
      end.join("\n")
    end

    protected

    def render_tag
      'div'
    end
  end
end
