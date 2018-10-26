require 'spec_helper'

mock_asset_hyperlink_node = {
  'data' => {
    'target' => MockAsset.new(
      {
        'fields' => {
          'title' => 'Foo',
          'file' => {
            'contentType' => 'image/jpeg',
            'url' => 'https://example.com/cat.jpg',
          },
        }
      }
    )
  },
  'content' => [{'value' => 'Example', 'nodeType' => 'text', 'marks' => []}],
}

describe RichTextRenderer::AssetHyperlinkRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer
    )
  end

  describe '#render' do
    it 'renders an a' do
      expect(subject.render(mock_asset_hyperlink_node)).to eq '<a href="https://example.com/cat.jpg">Example</a>'
    end
  end
end
