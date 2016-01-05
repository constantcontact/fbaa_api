module FbaaApi
  class Configuration
    # Sets which FBAA API version to use
    attr_accessor :api_version

    # Sets base url for FBAA
    attr_accessor :base_url

    # secret key shared by both the client and server
    attr_accessor :secret_key

    # identifies the client to the server
    attr_accessor :access_id

    # Set a logger, or use stdout by default
    attr_accessor :logger

    def initialize
      @api_version   = 'v1'
      @base_url      = ''
      @logger        = Logger.new(STDOUT)
      @secret_key    = ''
      @access_id     = ''
    end

  end
end
