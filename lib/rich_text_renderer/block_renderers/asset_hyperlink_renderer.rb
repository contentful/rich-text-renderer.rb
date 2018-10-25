require_relative './base_block_renderer'

module RichTextRenderer
  # Asset hyperlink renderer
  class AssetHyperlinkRenderer < BaseBlockRenderer
    # Anchor HTML Tag
    ANCHOR_HTML = ->(url, text) { "<a href=\"#{url}\">#{text}</a>" }

    # Renders asset nodes
    def render(node)
      asset = nil
      begin
        asset = node['data']['target']
      rescue
        fail "Node target is not an asset - Node: #{node}"
      end

      # Check by class name instead of instance type to
      # avoid dependending on the Contentful SDK.
      return render_asset(asset, node) if asset.class.ancestors.map(&:to_s).any? { |name| name.include?('Asset') }

      if asset.is_a?(::Hash)
        unless asset.key?('fields') && asset['fields'].key?('file')
          fail "Node target is not an asset - Node: #{node}"
        end

        return render_hash(asset, node)
      end

      fail "Node target is not an asset - Node: #{node}"
    end

    protected

    def render_asset(asset, node = nil)
      render!(
        ANCHOR_HTML,
        asset.url,
        renders_node?(node) ? node : asset.title,
        renders_node?(node)
      )
    end

    def render_hash(asset, node = nil)
      render!(
        ANCHOR_HTML,
        asset['fields']['file']['url'],
        renders_node?(node) ? node : asset['fields']['title'],
        renders_node?(node)
      )
    end

    def renders_node?(node)
      !(node.nil? || node.empty?) && (
        node.is_a?(::Hash) ? renders_node?(node['content']) : true
      )
    end

    def render!(markup, url, text, formatted = false)
      text = render_content(text) if formatted
      markup[url, text]
    end
  end
end
