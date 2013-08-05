require 'uri'

module OmniAuth
  class VKClient

    SITE = 'https://api.vk.com'
    ENDPOINT = '/method/users.get'

    attr_reader :client, :options, :logger

    def initialize(access_token, version, logger: nil)
      @client = Faraday.new( SITE )
      @options = { access_token: access_token, version: version }
      @logger = logger
    end

    def debug(msg)
      logger.debug("[OmniAuth::VkClient] " + msg) if logger
    end

    def response(fields)
      debug("request options: #{options.inspect}")
      request_options = options.dup.merge(fields: fields) if fields.present?
      client.get(URI.join(SITE, ENDPOINT), request_options).tap do |response|
        debug(response)
      end.parsed.first
    end

  end
end
