require File.expand_path('../lib/rich_text_renderer/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = 'rich_text_renderer'
  gem.version       = RichTextRenderer::VERSION
  gem.summary       = 'Rich Text Renderer for the Contentful RichText field type'
  gem.description   = 'Rich Text Renderer for the Contentful RichText field type'
  gem.license       = 'MIT'
  gem.authors       = ['Contentful GmbH (David Litvak Bruno)']
  gem.email         = 'rubygems@contentful.com'
  gem.homepage      = 'https://github.com/contentful/rich-text-renderer.rb'

  gem.files         = Dir['lib/**/*', 'CHANGELOG.md', 'LICENSE.txt', 'README.md']
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^spec/})
  gem.require_paths = ['lib']

  gem.add_development_dependency 'bundler'
  gem.add_development_dependency 'rake', '~> 13.1.0'
  gem.add_development_dependency 'rubygems-tasks', '~> 0.2'

  gem.add_development_dependency 'guard'
  gem.add_development_dependency 'guard-rspec'
  gem.add_development_dependency 'guard-rubocop'
  gem.add_development_dependency 'guard-yard'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rubocop', '~> 1.62.1'
  gem.add_development_dependency 'rspec', '~> 3'
  gem.add_development_dependency 'simplecov'
end
