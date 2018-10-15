require 'spec_helper'

mock_node = {"content" => [
  {
    "content" => [{
      "content" => [{
        "value" => "foo",
        "nodeType" => "text",
        "nodeClass" => "text"
      }],
      "nodeType" => "paragraph",
      "nodeClass" => "block"
    }],
    "nodeType" => "list-item",
    "nodeClass" => "block"
  }]
}

mock_node_with_marks = {"content" => [
  {
    "content" => [{
      "content" => [{
        "marks" => [{"type" => "bold"}],
        "value" => "foo",
        "nodeType" => "text",
        "nodeClass" => "text"
      }],
      "nodeType" => "paragraph",
      "nodeClass" => "block"
    }],
    "nodeType" => "list-item",
    "nodeClass" => "block"
  }]
}


describe RichTextRenderer::OrderedListRenderer do
  subject do
    described_class.new(
      'paragraph' => RichTextRenderer::ParagraphRenderer,
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
      'list-item' => RichTextRenderer::ListItemRenderer
    )
  end

  describe '#render' do
    it 'renders a ol' do
      expect(subject.render(mock_node)).to eq "<ol><li><p>foo</p></li></ol>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<ol><li><p><b>foo</b></p></li></ol>"
    end
  end
end
