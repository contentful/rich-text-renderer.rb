require 'spec_helper'

mock_node = {"content" => [{"value" => "foo", "nodeType" => "text"}]}

mock_node_with_marks = {"content" => [{"value" => "foo", "nodeType" => "text", "marks" => [{"type" => "bold"}]}]}

describe RichTextRenderer::HeadingSixRenderer do
  subject do
    described_class.new(
      'text' => RichTextRenderer::TextRenderer,
      'bold' => RichTextRenderer::BoldRenderer
    )
  end

  describe '#render' do
    it 'renders a h6' do
      expect(subject.render(mock_node)).to eq "<h6>foo</h6>"
    end

    it 'will propagate marks to text renderers' do
      expect(subject.render(mock_node_with_marks)).to eq "<h6><b>foo</b></h6>"
    end
  end
end
