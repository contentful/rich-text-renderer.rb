require 'spec_helper'

mock_node = {"nodeType" => "hr"}

describe RichTextRenderer::HrRenderer do
  subject { described_class.new }

  describe '#render' do
    it 'will render an hr' do
      expect(subject.render(mock_node)).to eq '<hr />'
    end
  end
end
