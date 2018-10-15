require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::BaseBlockRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
      'italic' => RichTextRenderer::ItalicRenderer,
      'underline' => RichTextRenderer::UnderlineRenderer
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
