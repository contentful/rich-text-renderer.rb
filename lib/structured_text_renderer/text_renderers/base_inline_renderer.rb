module StructuredTextRenderer
  # Base renderer for inline nodes.
  class BaseInlineRenderer
    attr_reader :mappings

    def initialize(mappings = {})
      @mappings = mappings
    end

    # Renders inline nodes.
    def render(node)
      "<#{render_tag}>#{node['value']}</#{render_tag}>"
    end

    protected

    def render_tag
      'span'
    end
  end
end
