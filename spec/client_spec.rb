require 'spec_helper'

RSpec.describe FbaaApi::Client do
  let(:client) {
    FbaaApi.configure { |c| c.base_url = 'https://example.com' }
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
    it 'calls request with proper arguments' do
      ad_params = { ad: { name: 'edited' } }
      expect(client).to receive(:request).with(:put, '/ads/123', ad_params)
      client.put '/ads/123', ad_params
    end

    it 'passes base_url to a new instance of Faraday' do
      base_url = 'https://example.com/api/v1'

      expect(Faraday).to receive(:new).with(url: base_url).and_call_original
      client.put '/ads/123'
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
