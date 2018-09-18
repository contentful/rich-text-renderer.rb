require 'spec_helper'

mock_node_underline_only = {"value" => "foo", "marks" => [{"type" => "underline"}]}

mock_node_italic_only = {"value" => "foo", "marks" => [{"type" => "italic"}]}

mock_node_bold_only = {"value" => "foo", "marks" => [{"type" => "bold"}]}

mock_node_multiple_marks = {
  "value" => "foo",
  "marks" => [{"type" => "underline"}, {"type" => "italic"}, {"type" => "bold"}],
}

mock_node_unsupported_mark = {"value" => "foo", "marks" => [{"type" => "foobar"}]}



describe StructuredTextRenderer::TextRenderer do
  subject do
    described_class.new(
      'bold' => StructuredTextRenderer::BoldRenderer,
      'italic' => StructuredTextRenderer::ItalicRenderer,
      'underline' => StructuredTextRenderer::UnderlineRenderer
    )
  end

  describe '#render' do
    it 'can render with a single mark' do
      expect(subject.render(mock_node_bold_only)).to eq "<b>foo</b>"
      expect(subject.render(mock_node_italic_only)).to eq "<i>foo</i>"
      expect(subject.render(mock_node_underline_only)).to eq "<u>foo</u>"
    end

    it 'can render multiple marks' do
      expect(subject.render(mock_node_multiple_marks)).to eq "<b><i><u>foo</u></i></b>"
    end

    it 'doesnt style unsupported marks' do
      expect(subject.render(mock_node_unsupported_mark)).to eq "foo"
    end

    it 'supports custom renderers' do
      subject = described_class.new(
        'bold' => BoldMarkdownRenderer
      )

      expect(subject.render(mock_node_bold_only)).to eq "**foo**"
    end
  end
end
