require 'spec_helper'

RSpec.describe FbaaApi::Client do
  let(:client) {
    FbaaApi.configure do |c|
      c.base_url = test_base_url
      c.access_id = test_access_id
      c.secret_key = test_secret_key
      c.logger = Logger.new('/dev/null')
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

    it 'calls request with proper arguments' do
      ad_params = { ad: { name: 'edited' } }
      expect(client).to receive(:request).with(:put, '/ads/123', ad_params)
      client.put '/ads/123', ad_params
    end

    it 'passes base_url to a new instance of RestClient' do
      fbaa_url = 'https://fbaa.herokuapp.com'
      expect_any_instance_of(RestClient::Request).to receive(:execute) {
        double(RestClient::Response, code: 200, body: { it: 'worked' }.to_json)
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

  describe '#validate_image', :vcr do
    let(:prms) {{
      image_url: 'http://www.rainforest-alliance.org/sites/default/files/uploads/4/capybara-family_15762686447_f9f8a0684a_o.jpg',
      ctct_campaign_id: '12341234'
    }}

    it 'returns a 200 response code' do
      res = client.validate_image(prms)
      expect(res[:status]).to eq 200
    end

    it 'returns a text to image ratio' do
      res = client.validate_image(prms)
      expect(res[:body]['text_to_image_ratio']).to an_instance_of Float
    end

  end

  describe 'bad auth credentials' do
    before do
      FbaaApi.configure do |c|
        c.base_url = test_base_url
        c.access_id = '1234'
        c.secret_key = test_secret_key
      end
    end

    let(:prms) {{
      image_url: 'http://whatever.com/notanimage.jpg',
      ctct_campaign_id: '12341234'
    }}

    it 'returns http code 401' do
      res = FbaaApi::Client.new.validate_image(prms)
      expect(res[:status]).to eq 401
    end

    it 'returns unauthorized message' do
      res = FbaaApi::Client.new.validate_image(prms)
      expect(res[:body]['error_messages']).to eq 'Unauthorized'
    end
  end

end
