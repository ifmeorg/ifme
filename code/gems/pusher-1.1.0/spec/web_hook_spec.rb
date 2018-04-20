require 'spec_helper'

require 'rack'
require 'stringio'

describe Pusher::WebHook do
  before :each do
    @hook_data = {
      "time_ms" => 123456,
      "events" => [
        {"name" => 'foo'}
      ]
    }
  end

  describe "initialization" do
    it "can be initialized with Rack::Request" do
      request = Rack::Request.new({
        'HTTP_X_PUSHER_KEY' => '1234',
        'HTTP_X_PUSHER_SIGNATURE' => 'asdf',
        'CONTENT_TYPE' => 'application/json',
        'rack.input' => StringIO.new(MultiJson.encode(@hook_data))
      })
      wh = Pusher::WebHook.new(request)
      expect(wh.key).to eq('1234')
      expect(wh.signature).to eq('asdf')
      expect(wh.data).to eq(@hook_data)
    end

    it "can be initialized with a hash" do
      request = {
        :key => '1234',
        :signature => 'asdf',
        :content_type => 'application/json',
        :body => MultiJson.encode(@hook_data),
      }
      wh = Pusher::WebHook.new(request)
      expect(wh.key).to eq('1234')
      expect(wh.signature).to eq('asdf')
      expect(wh.data).to eq(@hook_data)
    end
  end

  describe "after initialization" do
    before :each do
      @body = MultiJson.encode(@hook_data)
      request = {
        :key => '1234',
        :signature => hmac('asdf', @body),
        :content_type => 'application/json',
        :body => @body
      }

      @client = Pusher::Client.new
      @wh = Pusher::WebHook.new(request, @client)
    end

    it "should validate" do
      @client.key = '1234'
      @client.secret = 'asdf'
      expect(@wh).to be_valid
    end

    it "should not validate if key is wrong" do
      @client.key = '12345'
      @client.secret = 'asdf'
      expect(Pusher.logger).to receive(:warn).with("Received webhook with unknown key: 1234")
      expect(@wh).not_to be_valid
    end

    it "should not validate if secret is wrong" do
      @client.key = '1234'
      @client.secret = 'asdfxxx'
      digest = OpenSSL::Digest::SHA256.new
      expected = OpenSSL::HMAC.hexdigest(digest, @client.secret, @body)
      expect(Pusher.logger).to receive(:warn).with("Received WebHook with invalid signature: got #{@wh.signature}, expected #{expected}")
      expect(@wh).not_to be_valid
    end

    it "should validate with an extra token" do
      @client.key = '12345'
      @client.secret = 'xxx'
      expect(@wh.valid?({:key => '1234', :secret => 'asdf'})).to be_truthy
    end

    it "should validate with an array of extra tokens" do
      @client.key = '123456'
      @client.secret = 'xxx'
      expect(@wh.valid?([
        {:key => '12345', :secret => 'wtf'},
        {:key => '1234', :secret => 'asdf'}
      ])).to be_truthy
    end

    it "should not validate if all keys are wrong with extra tokens" do
      @client.key = '123456'
      @client.secret = 'asdf'
      expect(Pusher.logger).to receive(:warn).with("Received webhook with unknown key: 1234")
      expect(@wh.valid?({:key => '12345', :secret => 'asdf'})).to be_falsey
    end

    it "should not validate if secret is wrong with extra tokens" do
      @client.key = '123456'
      @client.secret = 'asdfxxx'
      expect(Pusher.logger).to receive(:warn).with(/Received WebHook with invalid signature/)
      expect(@wh.valid?({:key => '1234', :secret => 'wtf'})).to be_falsey
    end

    it "should expose events" do
      expect(@wh.events).to eq(@hook_data["events"])
    end

    it "should expose time" do
      expect(@wh.time).to eq(Time.at(123.456))
    end
  end
end
