module FbaaApi
  class Configuration
    # Sets which FBAA API version to use
    attr_accessor :api_version

    # Sets base url for FBAA
    attr_accessor :base_url

    # Sets ctct environment. For production, set env to nil.
    attr_accessor :env

    # Sets ctct token
    attr_accessor :token

    # Sets ctct token
    attr_accessor :fbaa_password

    # Set a logger, or use stdout by default
    attr_accessor :logger

    def initialize
      @api_version   = 'v1'
      @base_url      = ''
      @fbaa_password = ''
      @logger        = Logger.new(STDOUT)
    end

  end
end
