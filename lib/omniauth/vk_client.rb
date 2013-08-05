require 'uri'
require 'multi_json'

module OmniAuth
  class VKClient

    SITE = 'https://api.vk.com'
    ENDPOINT = '/method/users.get'

    attr_reader :client, :request_params, :logger

    def initialize(logger: nil, **request_params)
      @client = Faraday.new( SITE )
      @request_params = request_params
      @logger = logger

      debug("params: #{request_params.inspect}")
    end

    def debug(msg)
      logger.debug("[OmniAuth::VkClient] " + msg.inspect) if logger
    end

    def response
      @response ||=\
      client.get(URI.join(SITE, ENDPOINT), request_params).tap do |response|
        debug(response.headers)
        debug(response.body)
      end
    end

    def parsed_response
      @parsed_response ||=\
      MultiJson.load(response.body)["response"].first
    end

  end
end
