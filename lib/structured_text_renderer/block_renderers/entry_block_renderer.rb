module StructuredTextRenderer
  # Default embedded entry renderer.
  # Dumps entry to string.
  # This renderer should be overridden for your particular applications.
  class EntryBlockRenderer
    def initialize(_mappings = {}); end

    # Renders embedded entry node.
    def render(node)
      "<div>#{node['data']}</div>"
    end
  end
end
