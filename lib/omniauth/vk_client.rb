require 'uri'
require 'multi_json'

module OmniAuth
  class VKClient

    SITE = 'https://api.vk.com'

    attr_reader :client, :request_params, :logger

    def initialize(logger: nil, **request_params)
      @client = Faraday.new( SITE )
      @request_params = request_params
      @logger = logger
      debug("params: #{request_params.inspect}")
    end

    def get
      parse do
        client.get(URI.join(SITE, '/method/users.get'), request_params).tap do |response|
          debug(response.headers)
          debug(response.body)
        end
      end
    end

    protected

    def debug(msg)
      logger.debug("[OmniAuth::VkClient] " + msg.inspect) if logger
    end

    def parse &block
      MultiJson.load(block.call.body)["response"].first
    end

  end
end
