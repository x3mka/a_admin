# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'a_admin/version'

Gem::Specification.new do |spec|
  spec.name          = "a_admin"
  spec.version       = AAdmin::VERSION
  spec.authors       = ["Dmitry Boltrushko"]
  spec.email         = ["dboltrushko@cloudnexa.com"]
  spec.description   = %q{Angular Rails Admin}
  spec.summary       = %q{Angular Rails Admin}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sass-rails', '~> 4.0.0'
  spec.add_dependency 'bootstrap-sass', '3.0.2.1'

  spec.add_dependency 'devise', '3.0.2'
end
