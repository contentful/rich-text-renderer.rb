require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe StructuredTextRenderer::HeadingFourRenderer do
  subject do
    described_class.new(
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a h4' do
      expect(subject.render(mock_node)).to eq "<h4>foo</h4>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<h4><b>foo</b></h4>"
    end
  end
end
