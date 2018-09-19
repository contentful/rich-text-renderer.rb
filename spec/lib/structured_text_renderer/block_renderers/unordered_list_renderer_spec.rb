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


describe StructuredTextRenderer::UnorderedListRenderer do
  subject do
    described_class.new(
      'paragraph' => StructuredTextRenderer::ParagraphRenderer,
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer,
      'list-item' => StructuredTextRenderer::ListItemRenderer
    )
  end

  describe '#render' do
    it 'renders a ul' do
      expect(subject.render(mock_node)).to eq "<ul><li><p>foo</p></li></ul>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<ul><li><p><b>foo</b></p></li></ul>"
    end
  end
end
