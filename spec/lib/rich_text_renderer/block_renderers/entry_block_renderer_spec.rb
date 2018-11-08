require 'spec_helper'

mock_data_node = {
    "data" => {"target" => {"sys" => {"id" => "foo", "type" => "Link", "linkType" => "Entry"}}}
}

describe RichTextRenderer::EntryBlockRenderer do
  subject { described_class.new }

  describe '#render' do
    it 'will stringify node data' do
      expect(subject.render(mock_data_node)).to eq '<div>{"sys"=>{"id"=>"foo", "type"=>"Link", "linkType"=>"Entry"}}</div>'
    end
  end
end
