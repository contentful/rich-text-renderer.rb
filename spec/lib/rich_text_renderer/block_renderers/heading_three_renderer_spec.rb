require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::HeadingThreeRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a h3' do
      expect(subject.render(mock_node)).to eq "<h3>foo</h3>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<h3><b>foo</b></h3>"
    end
  end
end
