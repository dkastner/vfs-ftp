# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vfs/ftp/version'

Gem::Specification.new do |spec|
  spec.name          = "vfs-ftp"
  spec.version       = Vfs::Ftp::VERSION
  spec.authors       = ["Derek Kastner"]
  spec.email         = ["dkastner@gmail.com"]
  spec.description   = %q{TODO: Write a gem description}
  spec.summary       = %q{TODO: Write a gem summary}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'vfs'
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "fake_ftp"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14.1"
end
