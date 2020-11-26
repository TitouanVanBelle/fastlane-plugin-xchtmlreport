source('https://rubygems.org')

gemspec

gem 'rubocop', '~> 0.49.1'

plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
eval_gemfile(plugins_path) if File.exist?(plugins_path)
