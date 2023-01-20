# frozen_string_literal: true

require 'spec_helper'

mock_node = {"value" => "foo"}

describe RichTextRenderer::SuperscriptRenderer do
  subject { described_class.new }

  it 'renders as a superscript' do
    expect(subject.render(mock_node)).to eq "<sup>foo</sup>"
  end
end
