require 'spec_helper'

mock_node = {
      "content" => [
        {
          "nodeType" => "table-row",
          "data" => {},
          "content" => [
            {
              "nodeType" => "table-cell",
              "data" => {},
              "content" => [
                {
                  "nodeType" => "paragraph",
                  "data" => {},
                  "content" => [
                    {
                      "nodeType" => "text",
                      "data" => {},
                      "marks" => [],
                      "value" => "Hello world!"
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    }

mock_node_with_marks = {
  "content" => [
    {
      "nodeType" => "table-row",
      "data" => {},
      "content" => [
        {
          "nodeType" => "table-cell",
          "data" => {},
          "content" => [
            {
              "nodeType" => "paragraph",
              "data" => {},
              "content" => [
                {
                  "nodeType" => "text",
                  "data" => {},
                  "marks" => [{"type" => "bold"}],
                  "value" => "Hello world!"
                }
              ]
            }
          ]
        }
      ]
    }
  ]
}


describe RichTextRenderer::TableRenderer do
  subject do
    described_class.new(
      'paragraph' => RichTextRenderer::ParagraphRenderer,
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
      'table-row' => RichTextRenderer::TableRowRenderer,
      'table-cell' => RichTextRenderer::TableCellRenderer
    )
  end

  describe '#render' do
    it 'will render a table' do
      expect(subject.render(mock_node)).to eq '<table><tr><td><p>Hello world!</p></td></tr></table>'
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<table><tr><td><p><b>Hello world!</b></p></td></tr></table>"
    end
  end
end
