# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'easy_management/version'

Gem::Specification.new do |s|
  s.name          = 'easy_management'
  s.version       = EasyManagement::VERSION
  s.authors       = ['Cezar Almeida']
  s.email         = %w(cezar.almeidajr@gmail.com)

  s.summary       = 'Manage your ActiveRecord models records like a charm'
  s.homepage      = 'https://github.com/r4z3c/easy_management'
  s.license       = 'MIT'

  s.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|s|features)/})
  end

  s.bindir        = 'bin'
  s.executables   = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.add_dependency 'rails', '>=5'
  s.add_dependency 'kaminari'
  s.add_dependency 'jbuilder'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec'
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'model-builder'
  s.add_development_dependency 'sqlite3'
  s.add_development_dependency 'database_cleaner'
end
