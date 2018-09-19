require_relative './base_block_renderer'

module StructuredTextRenderer
  # a node renderer.
  class HyperlinkRenderer < BaseBlockRenderer
    # Renders hyperlink
    def render(node)
      content = node['content'].each_with_object([]) do |content_node, result|
        renderer = find_renderer(content_node)
        result << renderer.render(content_node)
      end.join
      "<a href=\"#{node['data']['uri']}\">#{content}</a>"
    end
  end
end
