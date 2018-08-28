require 'spec_helper'

mock_document = {
    "nodeType" => "document",
    "content" => [
        {
            "content" => [{"value" => "foo", "marks" => [{"type" => "bold"}]}],
            "nodeType" => "heading-1",
        }
    ],
}

mock_document_with_unknown_nodetype = {
    "nodeType" => "document",
    "content" => [
        {
            "content" => [{"value" => "foo", "marks" => [{"type" => "bold"}]}],
            "nodeType" => "unknown",
        }
    ],
}

describe StructuredTextRenderer::DocumentRenderer do
  let(:text_renderer) do
    StructuredTextRenderer::TextRenderer.new(
      bold_renderer: StructuredTextRenderer::BoldRenderer.new,
      italic_renderer: StructuredTextRenderer::ItalicRenderer.new,
      underline_renderer: StructuredTextRenderer::UnderlineRenderer.new
    )
  end

  subject do
    described_class.new(
      heading_one_renderer: StructuredTextRenderer::HeadingOneRenderer.new(text_renderer: text_renderer),
      heading_two_renderer: StructuredTextRenderer::HeadingTwoRenderer.new(text_renderer: text_renderer),
      paragraph_renderer: StructuredTextRenderer::ParagraphRenderer.new(text_renderer: text_renderer),
      entry_block_renderer: StructuredTextRenderer::EntryBlockRenderer.new
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
