require 'spec_helper'

mock_node = {
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

mock_node_with_marks = {
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

describe RichTextRenderer::TableCellRenderer do
  subject do
    described_class.new(
      'paragraph' => RichTextRenderer::ParagraphRenderer,
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer,
    )
  end

  describe '#render' do
    it 'will render a td' do
      expect(subject.render(mock_node)).to eq '<td><p>Hello world!</p></td>'
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<td><p><b>Hello world!</b></p></td>"
    end
  end
end
