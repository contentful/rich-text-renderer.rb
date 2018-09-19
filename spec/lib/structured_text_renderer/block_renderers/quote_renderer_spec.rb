require 'spec_helper'

mock_node = {"content" => [{"nodeType" => "paragraph", "content" => [{"value" => "foo", "nodeType" => "text"}]}]}

mock_node_with_marks = {"content" => [{"nodeType" => "paragraph", "content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}]}

describe StructuredTextRenderer::QuoteRenderer do
  subject do
    described_class.new(
      'paragraph' => StructuredTextRenderer::ParagraphRenderer,
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a blockqoute' do
      expect(subject.render(mock_node)).to eq "<blockqoute><p>foo</p></blockqoute>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<blockqoute><p><b>foo</b></p></blockqoute>"
    end
  end
end
