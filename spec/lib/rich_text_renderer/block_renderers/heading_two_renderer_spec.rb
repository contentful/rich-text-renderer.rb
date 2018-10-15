require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::HeadingTwoRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a h2' do
      expect(subject.render(mock_node)).to eq "<h2>foo</h2>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<h2><b>foo</b></h2>"
    end
  end
end
