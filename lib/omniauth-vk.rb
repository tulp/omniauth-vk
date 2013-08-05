require "omniauth-vk/version"
require "omniauth"

module OmniAuth
  module Strategies
    autoload :VK,  'omniauth/strategies/vk'
  end
  autoload :VKClient, 'omniauth/vk_client'
end

OmniAuth.config.add_camelization 'vk', 'VK'
