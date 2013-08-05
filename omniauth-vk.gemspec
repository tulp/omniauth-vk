# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "omniauth-vk/version"

Gem::Specification.new do |gem|
  gem.authors       = ["Eugene Hlyzov"]
  gem.email         = ["hlyzov@gmail.com"]
  gem.description   = %q{Unofficial OmniAuth strategy for VKontakte (vk.com)}
  gem.summary       = %q{Unofficial OmniAuth strategy for VKontakte (vk.com)}
  gem.homepage      = "https://github.com/tulp/omniauth-vk"

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = Dir["test/**/*"]
  gem.name          = "omniauth-vk"
  gem.require_paths = ["lib"]
  gem.version       = OmniAuth::VK::VERSION

  gem.add_dependency 'omniauth', '~> 1.1'
  gem.add_dependency 'omniauth-oauth2', '~> 1.1'

  %w(rake webmock rack-test simplecov mocha).each do |dependency|
    gem.add_development_dependency dependency
  end

end
