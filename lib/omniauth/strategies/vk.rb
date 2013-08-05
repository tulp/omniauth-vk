require 'omniauth/strategies/oauth2'

module OmniAuth
  module Strategies
    # Authenticate to VK utilizing OAuth 2.0 and retrieve
    # basic user information.
    # documentation available here:
    # http://vk.com/dev/authentication
    #
    # @example Basic Usage
    #     use OmniAuth::Strategies::VK, 'API Key', 'Secret Key'
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

      # Defaults for API call for fetching user information
      option :fields, %w(photo_50)

      option :info_proc, nil

      def api_response
        @api_response ||=\
          (VKClient.new(
                      logger: OmniAuth.config.logger,
                      **{
                        access_token: access_token.token,
                        v: options['v'],
                        fields: options['fields'].join(','),
                        user_id: uid
                      })
         ).parsed_response
      end

      uid { access_token['user_id'].to_s }

      # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
      info {
        if options.info_proc
          info_proc[api_response]
        else
          {
            first_name: api_response['first_name'],
            last_name: api_response['last_name'],
            # if VK should be nice, we would be happy
            email: access_token['email'],
            photo: api_response['photo_50']
          }
        end
      }

      extra { skip_info? ? {} : { raw_info: api_response } }

    end
  end
end
