require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe StructuredTextRenderer::ParagraphRenderer do
  subject do
    described_class.new(
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a h1' do
      expect(subject.render(mock_node)).to eq "<p>foo</p>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<p><b>foo</b></p>"
    end
  end
end
