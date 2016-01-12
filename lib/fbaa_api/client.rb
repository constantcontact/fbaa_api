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

    def request(method, path, params = {})
      url = "#{fbaa_url}/#{path}"
      req = RestClient::Request.new(
        url: url,
        headers: { params: params }.merge(headers),
        method: method
      )
      response = signed_request(req).execute

      config.logger.info("Fbaa::Client - status #{response.code}")
      config.logger.info("Fbaa::Client - body #{response.body}")

      { status: response.code, body: JSON.parse(response.body) }
    rescue JSON::ParserError
      { status: 500, body: { 'error_messages' => "JSON::ParseError #{response.body}" } }
    rescue => e
      if e.respond_to?(:response)
        response = e.response
        { status: response.code, body: JSON.parse(response.body) }
      else
        raise e
      end
    end

    def signed_request(request)
      ApiAuth.sign!(request, config.access_id, config.secret_key)
    end

    def fbaa_url
      @fbaa_url ||= "#{config.base_url}/api/#{config.api_version}"
    end

    def headers
      { 'Content-Type' => "application/json" }
    end

    def config
      FbaaApi.configuration
    end
  end
end

