require_relative './asset_hyperlink_renderer'

module RichTextRenderer
  # Asset block renderer
  class AssetBlockRenderer < AssetHyperlinkRenderer
    # IMG HTML Tag
    IMAGE_HTML = ->(url, text) { "<img src=\"#{url}\" alt=\"#{text}\" />" }

    protected

    def render_asset(asset, node = nil)
      if asset.file.respond_to?(:content_type) && asset.file.content_type.include?('image')
        return render!(IMAGE_HTML, asset.url, asset.title)
      end

      super
    end

    def render_hash(asset, node = nil)
      if asset.fetch('fields', {}).fetch('file', {}).fetch('contentType', '').include?('image')
        return render!(IMAGE_HTML, asset['fields']['file']['url'], asset['fields']['title'])
      end

      super
    end
  end
end
