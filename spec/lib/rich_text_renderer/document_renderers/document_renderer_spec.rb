require 'spec_helper'

mock_document = {
    "nodeType" => "document",
    "content" => [
        {
            "content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}],
            "nodeType" => "heading-1",
        }
    ],
}

mock_document_with_unknown_nodetype = {
    "nodeType" => "document",
    "content" => [
        {
            "content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}],
            "nodeType" => "unknown",
        }
    ],
}

describe RichTextRenderer::DocumentRenderer do
  subject do
    described_class.new(
      'heading-1' => RichTextRenderer::HeadingOneRenderer,
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
      nil => RichTextRenderer::NullRenderer
    )
  end

  describe '#render' do
    it 'propagates rendering to renderers' do
      expect(subject.render(mock_document)).to eq "<h1><b>foo</b></h1>"
    end

    it 'will raise an error unknown node types' do
      expect { subject.render(mock_document_with_unknown_nodetype) }.to raise_error "No renderer defined for 'unknown' nodes"
    end
  end
end
