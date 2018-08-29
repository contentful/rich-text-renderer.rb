require 'simplecov'
SimpleCov.start unless RUBY_PLATFORM == 'java'

require 'rspec'
require 'structured_text_renderer'

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

class HeadingOneMarkdownRenderer
  def initialize(config = {})
    @text_renderer = config[:text_renderer]
  end

  def render(node)
    node['content'].each_with_object([]) do |c, res|
      res << "# #{@text_renderer.render(c)}"
    end.join("\n")
  end
end

class HeadingTwoMarkdownRenderer
  def initialize(config = {})
    @text_renderer = config[:text_renderer]
  end

  def render(node)
    node['content'].each_with_object([]) do |c, res|
      res << "## #{@text_renderer.render(c)}"
    end.join("\n")
  end
end

class ParagraphMarkdownRenderer
  def initialize(config = {})
    @text_renderer = config[:text_renderer]
  end

  def render(node)
    paragraphs = node['content'].each_with_object([]) do |c, res|
      res << "#{@text_renderer.render(c)}"
    end.join("\n")

    "\n#{paragraphs}\n"
  end
end

class EntryBlockMarkdownRenderer
  def render(node)
    "\n```\n#{node['data']}\n```\n"
  end
end

class BoldMarkdownRenderer
  def render(node)
    "**#{node['value']}**"
  end
end

class ItalicMarkdownRenderer
  def render(node)
    "*#{node['value']}*"
  end
end

class UnderlineMarkdownRenderer
  def render(node)
    "__#{node['value']}__"
  end
end
