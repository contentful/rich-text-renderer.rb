require 'spec_helper'

describe RichTextRenderer::NullRenderer do
  subject { described_class.new }

  describe 'null renderer will raise errors for unknown nodes' do
    it 'will look for nodeType' do
      expect { subject.render({'nodeType' => 'foo'}) }.to raise_error "No renderer defined for 'foo' nodes"
    end

    it 'will look for type' do
      expect { subject.render({'type' => 'foo'}) }.to raise_error "No renderer defined for 'foo' nodes"
    end

    it 'if none of the above found, will dump the node' do
      expect { subject.render({'foo' => 'bar'}) }.to raise_error "No renderer defined for '{\"foo\"=>\"bar\"}' nodes"
    end
  end
end
