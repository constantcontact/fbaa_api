$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fbaa_api'
require 'rspec'
require 'rspec/its'
require 'vcr'
require 'pry'

require 'dotenv'
Dotenv.load

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/cassettes'
  c.configure_rspec_metadata!

  c.filter_sensitive_data('<ACCESS_ID>') do |interaction|
    CGI.escape(test_access_id)
  end

  c.filter_sensitive_data('<SECRET_KEY>') do |interaction|
    CGI.escape(test_secret_key)
  end
end

def test_base_url
  ENV['TEST_BASE_URL'] || 'https://fbaa.herokuapp.com'
end

def test_access_id
  ENV['TEST_ACCESS_ID'] || 'testaccessid'
end

def test_secret_key
  ENV['TEST_SECRET_KEY'] || 'testsecretkey'
end
