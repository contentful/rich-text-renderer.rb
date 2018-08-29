require 'spec_helper'

mock_node = {"value" => "foo"}

describe StructuredTextRenderer::UnderlineRenderer do
  subject { described_class.new }

  it 'renders as a u' do
    expect(subject.render(mock_node)).to eq "<u>foo</u>"
  end
end
