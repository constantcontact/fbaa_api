require 'spec_helper'

RSpec.describe FbaaApi do
  it 'has a version number' do
    expect(FbaaApi::VERSION).not_to be nil
  end

  describe '.new' do
    it 'returns an instance of client' do
      expect(FbaaApi::Client).to receive(:new)
      FbaaApi.new
    end
  end

  describe '.configuration' do
    it 'returns a configuration instance' do
      expect(FbaaApi.configuration).to be_a FbaaApi::Configuration
    end

    it 'memoizes @configuration' do
      FbaaApi.configuration

      expect(FbaaApi::Configuration).not_to receive(:new)
      FbaaApi.configuration
    end
  end

  describe '.configure' do
    it 'yields a configuration instance' do
      expect { |b| FbaaApi.configure(&b) }
        .to yield_with_args FbaaApi.configuration
    end
  end

  describe '.reset' do
    before do
      FbaaApi.configure do |c|
        c.base_url = 'foo'
      end
    end

    it 'resets the configuration' do
      FbaaApi.reset
      expect(FbaaApi.configuration.base_url).to eq ''
    end
  end
end
