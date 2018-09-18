require 'simplecov'
SimpleCov.start unless RUBY_PLATFORM == 'java'

require 'rspec'
require 'structured_text_renderer'

RSpec.configure do |config|
  config.filter_run :focus => true
  config.run_all_when_everything_filtered = true
end

class NodeRenderer
  attr_reader :mappings

  def initialize(mappings = {})
    @mappings = mappings
  end

  protected

  def find_renderer(node)
    renderer = mappings[node['nodeType']]
    return if renderer.nil?
    renderer.new(mappings)
  end
end

class HeadingOneMarkdownRenderer < NodeRenderer
  def render(node)
    node['content'].each_with_object([]) do |c, res|
      renderer = find_renderer(c)
      next if renderer.nil?
      res << "# #{renderer.render(c)}"
    end.join("\n")
  end
end

class HeadingTwoMarkdownRenderer < NodeRenderer
  def render(node)
    node['content'].each_with_object([]) do |c, res|
      renderer = find_renderer(c)
      next if renderer.nil?
      res << "## #{renderer.render(c)}"
    end.join("\n")
  end
end

class ParagraphMarkdownRenderer < NodeRenderer
  def render(node)
    paragraphs = node['content'].each_with_object([]) do |c, res|
      renderer = find_renderer(c)
      next if renderer.nil?
      res << "#{renderer.render(c)}"
    end.join("\n")

    "\n#{paragraphs}\n"
  end
end

class EntryBlockMarkdownRenderer < NodeRenderer
  def render(node)
    "\n```\n#{node['data']}\n```\n"
  end
end

class BoldMarkdownRenderer < NodeRenderer
  def render(node)
    "**#{node['value']}**"
  end
end

class ItalicMarkdownRenderer < NodeRenderer
  def render(node)
    "*#{node['value']}*"
  end
end

class UnderlineMarkdownRenderer < NodeRenderer
  def render(node)
    "__#{node['value']}__"
  end
end
