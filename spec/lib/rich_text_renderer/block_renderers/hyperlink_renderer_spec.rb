require 'spec_helper'

mock_node = {"data" => {"uri" => "https://foobar.com"}, "content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"data" => {"uri" => "https://foobar.com"}, "content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::HyperlinkRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders an a' do
      expect(subject.render(mock_node)).to eq '<a href="https://foobar.com">foo</a>'
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq '<a href="https://foobar.com"><b>foo</b></a>'
    end
  end
end
