require 'omniauth/strategies/oauth2'
require 'multi_json'

module OmniAuth
  module Strategies
    # Authenticate to Vkontakte utilizing OAuth 2.0 and retrieve
    # basic user information.
    # documentation available here:
    # http://vkontakte.ru/developers.php?o=-17680044&p=Authorization&s=0
    #
    # @example Basic Usage
    #     use OmniAuth::Strategies::Vkontakte, 'API Key', 'Secret Key'
    class VK < OmniAuth::Strategies::OAuth2

      option :client_options, {
        site: 'https://oauth.vk.com',
        token_url: '/access_token',
        authorize_url: '/authorize'
      }

      # VK API Version
      option :v, '5.0'

      option :scope, nil
      option :display, 'popup'
      option :authorize_options, %i(scope v display)

      # defaults for API call for fetching user information
      option :fields, ['photo_50']
      option :logger, nil
      option :info_proc, nil

      def api_response
        @api_response ||=\
        VKClient.new(access_token.token, options.version, logger: options.logger).response
      end

      uid { access_token['user_id'].to_s }

      # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
      info {
        if options.info_proc
          info_proc[api_response]
        else
          [:first_name, :last_name, :image].inject do |auth_hash, key|
            auth_hash[key] = api_response[key]
            auth_hash
          end
        end.tap do |auth_hash|
          # if VK should be nice, we would be happy
          auth_hash[:email] = access_token['email']
        end
      }

      extra {{ raw_info: api_response }}

    end
  end
end
