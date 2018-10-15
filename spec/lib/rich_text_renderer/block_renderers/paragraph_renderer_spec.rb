require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

mock_node_with_multiple_content_nodes = {"content" => [{"value" => "foo", "nodeType" => "text"}, {"value" => " bar", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::ParagraphRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a p' do
      expect(subject.render(mock_node)).to eq "<p>foo</p>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<p><b>foo</b></p>"
    end

    it 'will properly render multiple content nodes' do
      expect(subject.render(mock_node_with_multiple_content_nodes)).to eq "<p>foo<b> bar</b></p>"
    end
  end
end
