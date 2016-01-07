require 'logger'
require 'json'
require 'rest_client'
require 'api-auth'
require 'fbaa_api/client'
require "fbaa_api/version"
require "fbaa_api/configuration"

module FbaaApi
  class << self
    attr_writer :configuration

    def new
      Client.new
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield configuration
    end

    def reset
      self.configuration = Configuration.new
    end
  end

end
