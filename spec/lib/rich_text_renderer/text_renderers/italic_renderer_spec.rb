require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::ItalicRenderer do
  subject { described_class.new }

  it 'renders as a i' do
    expect(subject.render(mock_node)).to eq "<i>foo</i>"
  end
end
