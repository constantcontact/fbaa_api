require 'spec_helper'

RSpec.describe FbaaApi::Client do
  let(:client) {
    FbaaApi.configure do |c|
      c.base_url = 'https://example.com'
      c.access_id = '13234'
      c.secret_key = 'asdf1234'
    end

    FbaaApi::Client.new
  }

  describe '#get' do
    it 'calls request with proper arguments' do
      ad_params = { some_params: 'qwerqwer' }
      expect(client).to receive(:request).with(:get, '/ads', ad_params)
      client.get '/ads', ad_params
    end
  end

  describe '#post' do
    it 'calls request with proper arguments' do
      ad_params = { some_params: 'qwerqwer' }
      expect(client).to receive(:request).with(:post, '/ads', ad_params)
      client.post '/ads', ad_params
    end
  end

  describe '#put' do
    before do
    end

    it 'calls request with proper arguments' do
      ad_params = { ad: { name: 'edited' } }
      expect(client).to receive(:request).with(:put, '/ads/123', ad_params)
      client.put '/ads/123', ad_params
    end

    it 'passes base_url to a new instance of RestClient' do
      base_url = 'https://example.com/api/v1'
      expect_any_instance_of(RestClient::Request).to receive(:execute) {
        double(RestClient::Response, status: 200, body: { it: 'worked' }.to_json)
      }
      client.put '/ads/123', foo: 'bar'
    end
  end

  describe '#delete' do
    it 'calls request with proper arguments' do
      ad_params = { some_params: 'qwerqwer' }
      expect(client).to receive(:request).with(:delete, '/ads', ad_params)
      client.delete '/ads', ad_params
    end
  end
end
