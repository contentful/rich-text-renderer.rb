require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::BoldRenderer do
  subject { described_class.new }

  it 'renders as a b' do
    expect(subject.render(mock_node)).to eq "<b>foo</b>"
  end
end
