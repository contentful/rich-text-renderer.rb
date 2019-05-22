require 'spec_helper'

mock_node_underline_only = {"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "underline"}]}

mock_node_italic_only = {"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "italic"}]}

mock_node_bold_only = {"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}

mock_node_multiple_marks = {
  "value" => "foo",
  "nodeType" => "text",
  "marks" => [{"type" => "underline"}, {"type" => "italic"}, {"type" => "bold"}],
}

mock_node_unsupported_mark = {"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "foobar"}]}

mock_node_unsafe_value = {"value" => "<script>alert('XSS!');</script>", "nodeType" => "text", "marks" => []}

mock_node_unsafe_value_with_marks = {"value" => "<script>alert('XSS!');</script>", "nodeType" => "text", "marks" => [{"type" => "underline"}, {"type" => "italic"}, {"type" => "bold"}]}

describe RichTextRenderer::TextRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
      'italic' => RichTextRenderer::ItalicRenderer,
      'underline' => RichTextRenderer::UnderlineRenderer,
      nil => RichTextRenderer::NullRenderer
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

    it 'raises an error for unsupported marks' do
      expect { subject.render(mock_node_unsupported_mark) }.to raise_error "No renderer defined for 'foobar' nodes"
    end

    it 'supports custom renderers' do
      subject = described_class.new(
        'text' => RichTextRenderer::TextRenderer,
        'bold' => BoldMarkdownRenderer,
        nil => RichTextRenderer::NullRenderer
      )

      expect(subject.render(mock_node_bold_only)).to eq "**foo**"
    end

    it 'escapes value' do
      expect(subject.render(mock_node_unsafe_value)).to eq "&lt;script&gt;alert(&#39;XSS!&#39;);&lt;/script&gt;"
    end

    it 'renders marks but keeps value escaped' do
      expect(subject.render(mock_node_unsafe_value_with_marks)).to eq "<b><i><u>&lt;script&gt;alert(&#39;XSS!&#39;);&lt;/script&gt;</u></i></b>"
    end
  end
end
