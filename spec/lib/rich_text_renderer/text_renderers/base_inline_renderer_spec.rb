require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::BaseInlineRenderer do
  subject { described_class.new }

  it 'renders as a span' do
    expect(subject.render(mock_node)).to eq "<span>foo</span>"
  end
end
