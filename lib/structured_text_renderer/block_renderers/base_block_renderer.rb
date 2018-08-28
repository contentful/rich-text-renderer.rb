module StructuredTextRenderer
  # Base renderer for block type nodes
  class BaseBlockRenderer
    attr_reader :text_renderer

    def initialize(config = {})
      @text_renderer = config[:text_renderer]
    end

    # Renders block type nodes.
    def render(node)
      node['content'].each_with_object([]) do |content, result|
        result << "<#{render_tag}>#{text_renderer.render(content)}</#{render_tag}>"
      end.join("\n")
    end

    protected

    def render_tag
      'div'
    end
  end
end
