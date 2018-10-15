require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::ListItemRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a li' do
      expect(subject.render(mock_node)).to eq "<li>foo</li>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<li><b>foo</b></li>"
    end
  end
end
