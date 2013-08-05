$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)
require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'rack/test'
require 'webmock/minitest'
require "mocha/setup"

require 'omniauth'
require 'omniauth-vk'

class WebMockTest < MiniTest::Spec
  include WebMock::API
  include Rack::Test::Methods
  extend  OmniAuth::Test::StrategyMacros
  register_spec_type(/strategies/, self)
end
