require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe StructuredTextRenderer::BaseBlockRenderer do
  subject do
    described_class.new(
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer,
      'italic' => StructuredTextRenderer::ItalicRenderer,
      'underline' => StructuredTextRenderer::UnderlineRenderer
    )
  end

  describe '#render' do
    it 'by defaults renders a div' do
      expect(subject.render(mock_node)).to eq "<div>foo</div>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<div><b>foo</b></div>"
    end
  end
end
