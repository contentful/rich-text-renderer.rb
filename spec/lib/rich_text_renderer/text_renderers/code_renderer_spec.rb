require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::CodeRenderer do
  subject { described_class.new }

  it 'renders as a code' do
    expect(subject.render(mock_node)).to eq "<code>foo</code>"
  end
end
