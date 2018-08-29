require 'spec_helper'

mock_node = {"content" => [{"value" => "foo"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "marks" => [{"type" => "bold"}]}]}

describe StructuredTextRenderer::ParagraphRenderer do
  let(:text_renderer) do
    StructuredTextRenderer::TextRenderer.new(
      bold_renderer: StructuredTextRenderer::BoldRenderer.new,
      italic_renderer: StructuredTextRenderer::ItalicRenderer.new,
      underline_renderer: StructuredTextRenderer::UnderlineRenderer.new
    )
  end

  subject do
    described_class.new(
      text_renderer: text_renderer
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
