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

describe StructuredTextRenderer::DocumentRenderer do
  subject do
    described_class.new(
      'heading-1' => StructuredTextRenderer::HeadingOneRenderer,
      'text' => StructuredTextRenderer::TextRenderer,
      'bold' => StructuredTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'propagates rendering to renderers' do
      expect(subject.render(mock_document)).to eq "<h1><b>foo</b></h1>"
    end

    it 'will skip unknown node types' do
      expect(subject.render(mock_document_with_unknown_nodetype)).to eq ""
    end
  end
end
