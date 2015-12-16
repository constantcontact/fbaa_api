module FbaaApi
  class Configuration
    # Sets which FBAA API version to use
    attr_accessor :api_version

    # Sets base url for FBAA
    attr_accessor :base_url

    # Sets ctct token
    attr_accessor :token

    def initialize
      @api_version = 'v1'
      @base_url    = ''
      @token       = ''
    end

  end
end
