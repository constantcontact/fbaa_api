module FbaaApi
  class Client

    def get(path, params = {})
      request(:get, path, params)
    end

    def post(path, params = {})
      request(:post, path, params)
    end

    def put(path, params = {})
      request(:put, path, params)
    end

    def delete(path, params = {})
      request(:delete, path, params)
    end

    def create_ad(params = {})
      post 'ads', params
    end

    def update_ad(id, params = {})
      put "ads/#{id}", params
    end

    def get_ad(id, params = {})
      get "ads/#{id}", params
    end

    def validate_image(params = {})
      get "image_validations", params
    end

    private

    def fbaa_url
      @fbaa_url ||= "#{config.base_url}/api/#{config.api_version}"
    end

    def connection(opts = {})
      opts[:headers] ||= { 'Accept' => 'application/json' }
      config.logger.info("Fbaa::Client - fbaa_url #{fbaa_url}")
      Faraday.new(url: fbaa_url) do |faraday|
        faraday.headers = opts[:headers]
        # this is required to be after headers to work
        faraday.basic_auth 'roving', config.fbaa_password
        faraday.request :url_encoded
        faraday.adapter Faraday.default_adapter
      end
    end

    def request(method, path, params = {})
      config.logger.info("Fbaa::Client - path #{path}")
      response = connection.send(method, path) do |request|
        request.body = params if [:post, :put].include? method
        request.params = params
      end
      config.logger.info("Fbaa::Client - status #{response.status}")
      config.logger.info("Fbaa::Client - body #{response.body}")

      { status: response.status, body: JSON.parse(response.body) }
    rescue JSON::ParserError
      { status: 500, body: { error_messages: "JSON::ParseError #{response.body}" } }
    end

    def config
      FbaaApi.configuration
    end

  end
end

