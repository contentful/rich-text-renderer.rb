require 'spec_helper'

mock_image_asset_node = {
  'data' => {
    'target' => {
      'fields' => {
        'title' => 'Foo',
        'file' => {
          'contentType' => 'image/jpeg',
          'url' => 'https://example.com/cat.jpg',
        },
      }
    }
  }
}

mock_image_asset_resolved_node = {
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
  }
}

mock_non_image_asset_node = {
  'data' => {
    'target' => {
      'fields' => {
        'title' => 'Foo',
        'file' => {
          'contentType' => 'text/csv',
          'url' => 'https://example.com/cat.csv',
        },
      }
    }
  }
}

mock_non_image_asset_resolved_node = {
  'data' => {
    'target' => MockAsset.new(
      {
        'fields' => {
          'title' => 'Foo',
          'file' => {
            'contentType' => 'text/csv',
            'url' => 'https://example.com/cat.csv',
          },
        }
      }
    )
  }
}

describe RichTextRenderer::AssetBlockRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer
    )
  end

  describe '#render' do
    it 'renders an image asset hash as img' do
      expect(subject.render(mock_image_asset_node)).to eq '<img src="https://example.com/cat.jpg" alt="Foo" />'
    end

    it 'renders an image asset object as img' do
      expect(subject.render(mock_image_asset_resolved_node)).to eq '<img src="https://example.com/cat.jpg" alt="Foo" />'
    end

    it 'renders a non image hash as an a' do
      expect(subject.render(mock_non_image_asset_node)).to eq '<a href="https://example.com/cat.csv">Foo</a>'
    end

    it 'renders a non image object as an a' do
      expect(subject.render(mock_non_image_asset_resolved_node)).to eq '<a href="https://example.com/cat.csv">Foo</a>'
    end

    describe 'errors' do
      it 'raises exception when node is not a data node' do
        expect { subject.render({}) }.to raise_exception 'Node target is not an asset - Node: {}'
      end

      it 'raises exception when target is nil' do
        expect { subject.render({ 'data' => { 'target' => nil }}) }.to raise_exception 'Node target is not an asset - Node: {"data"=>{"target"=>nil}}'
      end

      it 'raises exception when target does not contain asset fields' do
        expect { subject.render({ 'data' => { 'target' => {} }}) }.to raise_exception 'Node target is not an asset - Node: {"data"=>{"target"=>{}}}'
      end
    end
  end
end
