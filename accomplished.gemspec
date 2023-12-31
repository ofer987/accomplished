# frozen_string_literal: true

require_relative 'lib/accomplished/version'

Gem::Specification.new do |spec|
  spec.name = 'accomplished'
  spec.version = Accomplished::VERSION
  spec.authors = ['Dan Jakob Ofer']
  spec.email = ['dan@ofer.to']

  spec.summary = 'Display developed User Stories for given sprint'
  spec.required_ruby_version = '~> 3.1.0'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split('\x0').reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 7.0.6'
  spec.add_dependency 'base64', '~> 0.1.1'
  spec.add_dependency 'json', '~> 2.6.2'
  spec.add_dependency 'mustache', '~> 1.1.1'
  spec.add_dependency 'rest-client', '~> 2.1.0'
end
