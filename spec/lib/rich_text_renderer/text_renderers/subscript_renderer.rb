# frozen_string_literal: true

require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::SubscriptRenderer do
  subject { described_class.new }

  it 'renders as a subscript' do
    expect(subject.render(mock_node)).to eq "<sub>foo</sub>"
  end
end
