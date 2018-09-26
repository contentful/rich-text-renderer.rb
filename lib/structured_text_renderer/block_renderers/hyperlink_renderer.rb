require_relative './base_block_renderer'

module StructuredTextRenderer
  # a node renderer.
  class HyperlinkRenderer < BaseBlockRenderer
    # Renders hyperlink
    def render(node)
      "<a href=\"#{node['data']['uri']}\">#{render_content(node)}</a>"
    end
  end
end
