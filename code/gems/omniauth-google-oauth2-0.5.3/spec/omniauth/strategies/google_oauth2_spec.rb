# frozen_string_literal: true

require 'spec_helper'
require 'json'
require 'omniauth-google-oauth2'

describe OmniAuth::Strategies::GoogleOauth2 do
  let(:request) { double('Request', params: {}, cookies: {}, env: {}) }
  let(:app) do
    lambda do
      [200, {}, ['Hello.']]
    end
  end

  subject do
    OmniAuth::Strategies::GoogleOauth2.new(app, 'appid', 'secret', @options || {}).tap do |strategy|
      allow(strategy).to receive(:request) do
        request
      end
    end
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  describe '#client_options' do
    it 'has correct site' do
      expect(subject.client.site).to eq('https://accounts.google.com')
    end

    it 'has correct authorize_url' do
      expect(subject.client.options[:authorize_url]).to eq('/o/oauth2/auth')
    end

    it 'has correct token_url' do
      expect(subject.client.options[:token_url]).to eq('/o/oauth2/token')
    end

    describe 'overrides' do
      context 'as strings' do
        it 'should allow overriding the site' do
          @options = { client_options: { 'site' => 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { 'authorize_url' => 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { 'token_url' => 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end

      context 'as symbols' do
        it 'should allow overriding the site' do
          @options = { client_options: { site: 'https://example.com' } }
          expect(subject.client.site).to eq('https://example.com')
        end

        it 'should allow overriding the authorize_url' do
          @options = { client_options: { authorize_url: 'https://example.com' } }
          expect(subject.client.options[:authorize_url]).to eq('https://example.com')
        end

        it 'should allow overriding the token_url' do
          @options = { client_options: { token_url: 'https://example.com' } }
          expect(subject.client.options[:token_url]).to eq('https://example.com')
        end
      end
    end
  end

  describe '#authorize_options' do
    %i[access_type hd login_hint prompt scope state device_id device_name].each do |k|
      it "should support #{k}" do
        @options = { k => 'http://someval' }
        expect(subject.authorize_params[k.to_s]).to eq('http://someval')
      end
    end

    describe 'redirect_uri' do
      it 'should default to nil' do
        @options = {}
        expect(subject.authorize_params['redirect_uri']).to eq(nil)
      end

      it 'should set the redirect_uri parameter if present' do
        @options = { redirect_uri: 'https://example.com' }
        expect(subject.authorize_params['redirect_uri']).to eq('https://example.com')
      end
    end

    describe 'access_type' do
      it 'should default to "offline"' do
        @options = {}
        expect(subject.authorize_params['access_type']).to eq('offline')
      end

      it 'should set the access_type parameter if present' do
        @options = { access_type: 'online' }
        expect(subject.authorize_params['access_type']).to eq('online')
      end
    end

    describe 'hd' do
      it 'should default to nil' do
        expect(subject.authorize_params['hd']).to eq(nil)
      end

      it 'should set the hd (hosted domain) parameter if present' do
        @options = { hd: 'example.com' }
        expect(subject.authorize_params['hd']).to eq('example.com')
      end

      it 'should set the hd parameter and work with nil hd (gmail)' do
        @options = { hd: nil }
        expect(subject.authorize_params['hd']).to eq(nil)
      end

      it 'should set the hd parameter to * if set (only allows G Suite emails)' do
        @options = { hd: '*' }
        expect(subject.authorize_params['hd']).to eq('*')
      end
    end

    describe 'login_hint' do
      it 'should default to nil' do
        expect(subject.authorize_params['login_hint']).to eq(nil)
      end

      it 'should set the login_hint parameter if present' do
        @options = { login_hint: 'john@example.com' }
        expect(subject.authorize_params['login_hint']).to eq('john@example.com')
      end
    end

    describe 'prompt' do
      it 'should default to nil' do
        expect(subject.authorize_params['prompt']).to eq(nil)
      end

      it 'should set the prompt parameter if present' do
        @options = { prompt: 'consent select_account' }
        expect(subject.authorize_params['prompt']).to eq('consent select_account')
      end
    end

    describe 'request_visible_actions' do
      it 'should default to nil' do
        expect(subject.authorize_params['request_visible_actions']).to eq(nil)
      end

      it 'should set the request_visible_actions parameter if present' do
        @options = { request_visible_actions: 'something' }
        expect(subject.authorize_params['request_visible_actions']).to eq('something')
      end
    end

    describe 'include_granted_scopes' do
      it 'should default to nil' do
        expect(subject.authorize_params['include_granted_scopes']).to eq(nil)
      end

      it 'should set the include_granted_scopes parameter if present' do
        @options = { include_granted_scopes: 'true' }
        expect(subject.authorize_params['include_granted_scopes']).to eq('true')
      end
    end

    describe 'scope' do
      it 'should expand scope shortcuts' do
        @options = { scope: 'plus.me' }
        expect(subject.authorize_params['scope']).to eq('https://www.googleapis.com/auth/plus.me')
      end

      it 'should leave base scopes as is' do
        @options = { scope: 'profile' }
        expect(subject.authorize_params['scope']).to eq('profile')
      end

      it 'should join scopes' do
        @options = { scope: 'profile,email' }
        expect(subject.authorize_params['scope']).to eq('profile email')
      end

      it 'should deal with whitespace when joining scopes' do
        @options = { scope: 'profile, email' }
        expect(subject.authorize_params['scope']).to eq('profile email')
      end

      it 'should set default scope to email,profile' do
        expect(subject.authorize_params['scope']).to eq('email profile')
      end

      it 'should support space delimited scopes' do
        @options = { scope: 'profile email' }
        expect(subject.authorize_params['scope']).to eq('profile email')
      end

      it 'should support extremely badly formed scopes' do
        @options = { scope: 'profile email,foo,steve yeah http://example.com' }
        expect(subject.authorize_params['scope']).to eq('profile email https://www.googleapis.com/auth/foo https://www.googleapis.com/auth/steve https://www.googleapis.com/auth/yeah http://example.com')
      end
    end

    describe 'state' do
      it 'should set the state parameter' do
        @options = { state: 'some_state' }
        expect(subject.authorize_params['state']).to eq('some_state')
        expect(subject.authorize_params[:state]).to eq('some_state')
        expect(subject.session['omniauth.state']).to eq('some_state')
      end

      it 'should set the omniauth.state dynamically' do
        allow(subject).to receive(:request) { double('Request', params: { 'state' => 'some_state' }, env: {}) }
        expect(subject.authorize_params['state']).to eq('some_state')
        expect(subject.authorize_params[:state]).to eq('some_state')
        expect(subject.session['omniauth.state']).to eq('some_state')
      end
    end

    describe 'overrides' do
      it 'should include top-level options that are marked as :authorize_options' do
        @options = { authorize_options: %i[scope foo request_visible_actions], scope: 'http://bar', foo: 'baz', hd: 'wow', request_visible_actions: 'something' }
        expect(subject.authorize_params['scope']).to eq('http://bar')
        expect(subject.authorize_params['foo']).to eq('baz')
        expect(subject.authorize_params['hd']).to eq(nil)
        expect(subject.authorize_params['request_visible_actions']).to eq('something')
      end

      describe 'request overrides' do
        %i[access_type hd login_hint prompt scope state].each do |k|
          context "authorize option #{k}" do
            let(:request) { double('Request', params: { k.to_s => 'http://example.com' }, cookies: {}, env: {}) }

            it "should set the #{k} authorize option dynamically in the request" do
              @options = { k: '' }
              expect(subject.authorize_params[k.to_s]).to eq('http://example.com')
            end
          end
        end

        describe 'custom authorize_options' do
          let(:request) { double('Request', params: { 'foo' => 'something' }, cookies: {}, env: {}) }

          it 'should support request overrides from custom authorize_options' do
            @options = { authorize_options: [:foo], foo: '' }
            expect(subject.authorize_params['foo']).to eq('something')
          end
        end
      end
    end
  end

  describe '#authorize_params' do
    it 'should include any authorize params passed in the :authorize_params option' do
      @options = { authorize_params: { request_visible_actions: 'something', foo: 'bar', baz: 'zip' }, hd: 'wow', bad: 'not_included' }
      expect(subject.authorize_params['request_visible_actions']).to eq('something')
      expect(subject.authorize_params['foo']).to eq('bar')
      expect(subject.authorize_params['baz']).to eq('zip')
      expect(subject.authorize_params['hd']).to eq('wow')
      expect(subject.authorize_params['bad']).to eq(nil)
    end
  end

  describe '#token_params' do
    it 'should include any token params passed in the :token_params option' do
      @options = { token_params: { foo: 'bar', baz: 'zip' } }
      expect(subject.token_params['foo']).to eq('bar')
      expect(subject.token_params['baz']).to eq('zip')
    end
  end

  describe '#token_options' do
    it 'should include top-level options that are marked as :token_options' do
      @options = { token_options: %i[scope foo], scope: 'bar', foo: 'baz', bad: 'not_included' }
      expect(subject.token_params['scope']).to eq('bar')
      expect(subject.token_params['foo']).to eq('baz')
      expect(subject.token_params['bad']).to eq(nil)
    end
  end

  describe '#callback_path' do
    it 'has the correct default callback path' do
      expect(subject.callback_path).to eq('/auth/google_oauth2/callback')
    end

    it 'should set the callback_path parameter if present' do
      @options = { callback_path: '/auth/foo/callback' }
      expect(subject.callback_path).to eq('/auth/foo/callback')
    end
  end

  describe '#extra' do
    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/plus/v1/people/me/openIdConnect') { [200, { 'content-type' => 'application/json' }, '{"sub": "12345"}'] }
          stub.get('/plus/v1/people/12345/people/visible') { [200, { 'content-type' => 'application/json' }, '[{"foo":"bar"}]'] }
          stub.get('/plus/v1/people/12345?fields=image') { [200, { 'content-type' => 'application/json' }, '{"image":"imageData"}'] }
        end
      end
    end
    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }

    before { allow(subject).to receive(:access_token).and_return(access_token) }

    describe 'id_token' do
      context 'when the id_token is passed into the access token' do
        token_info =
          {
            'abc' => 'xyz',
            'exp' => Time.now.to_i + 3600,
            'nbf' => Time.now.to_i - 60,
            'iat' => Time.now.to_i,
            'aud' => 'appid',
            'iss' => 'accounts.google.com'
          }
        id_token = JWT.encode(token_info, 'secret')
        let(:access_token) { OAuth2::AccessToken.from_hash(client, 'id_token' => id_token) }

        it 'should include id_token when set on the access_token' do
          expect(subject.extra).to include(id_token: id_token)
        end

        it 'should include id_info when id_token is set on the access_token and skip_jwt is false' do
          subject.options[:skip_jwt] = false
          expect(subject.extra).to include(id_info: token_info)
        end

        it 'should not include id_info when id_token is set on the access_token and skip_jwt is true' do
          subject.options[:skip_jwt] = true
          expect(subject.extra).not_to have_key(:id_info)
        end

        it 'should include id_info when id_token is set on the access_token by default' do
          expect(subject.extra).to include(id_info: token_info)
        end
      end

      context 'when the id_token is missing' do
        it 'should not include id_token' do
          expect(subject.extra).not_to have_key(:id_token)
        end

        it 'should not include id_info' do
          expect(subject.extra).not_to have_key(:id_info)
        end
      end
    end

    describe 'raw_info' do
      context 'when skip_info is true' do
        before { subject.options[:skip_info] = true }

        it 'should not include raw_info' do
          expect(subject.extra).not_to have_key(:raw_info)
        end
      end

      context 'when skip_info is false' do
        before { subject.options[:skip_info] = false }

        it 'should include raw_info' do
          expect(subject.extra[:raw_info]).to eq('sub' => '12345')
        end
      end
    end

    describe 'raw_friend_info' do
      context 'when skip_info is true' do
        before { subject.options[:skip_info] = true }

        it 'should not include raw_friend_info' do
          expect(subject.extra).not_to have_key(:raw_friend_info)
        end
      end

      context 'when skip_info is false' do
        before { subject.options[:skip_info] = false }

        context 'when skip_friends is true' do
          before { subject.options[:skip_friends] = true }

          it 'should not include raw_friend_info' do
            expect(subject.extra).not_to have_key(:raw_friend_info)
          end
        end

        context 'when skip_friends is false' do
          before { subject.options[:skip_friends] = false }

          it 'should not include raw_friend_info' do
            expect(subject.extra[:raw_friend_info]).to eq([{ 'foo' => 'bar' }])
          end
        end
      end
    end

    describe 'raw_image_info' do
      context 'when skip_info is true' do
        before { subject.options[:skip_info] = true }

        it 'should not include raw_image_info' do
          expect(subject.extra).not_to have_key(:raw_image_info)
        end
      end

      context 'when skip_info is false' do
        before { subject.options[:skip_info] = false }

        context 'when skip_image_info is true' do
          before { subject.options[:skip_image_info] = true }

          it 'should not include raw_image_info' do
            expect(subject.extra).not_to have_key(:raw_image_info)
          end
        end

        context 'when skip_image_info is false' do
          before { subject.options[:skip_image_info] = false }

          it 'should include raw_image_info' do
            expect(subject.extra[:raw_image_info]).to eq('image' => 'imageData')
          end
        end
      end
    end
  end

  describe 'populate auth hash urls' do
    it 'should populate url map in auth hash if link present in raw_info' do
      allow(subject).to receive(:raw_info) { { 'name' => 'Foo', 'profile' => 'https://plus.google.com/123456' } }
      expect(subject.info[:urls][:google]).to eq('https://plus.google.com/123456')
    end

    it 'should not populate url map in auth hash if no link present in raw_info' do
      allow(subject).to receive(:raw_info) { { 'name' => 'Foo' } }
      expect(subject.info).not_to have_key(:urls)
    end
  end

  describe 'image options' do
    it 'should have no image if a picture is not present' do
      @options = { image_aspect_ratio: 'square' }
      allow(subject).to receive(:raw_info) { { 'name' => 'User Without Pic' } }
      expect(subject.info[:image]).to be_nil
    end

    describe 'when a picture is returned from google' do
      it 'should return the image with size specified in the `image_size` option' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50/photo.jpg')
      end

      it 'should handle a picture with too many slashes correctly' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url//photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50/photo.jpg')
      end

      it 'should handle a picture with a size query parameter correctly' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg?sz=50' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50/photo.jpg')
      end

      it 'should handle a picture with a size query parameter and other valid query parameters correctly' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg?sz=50&hello=true&life=42' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50/photo.jpg?hello=true&life=42')
      end

      it 'should handle a picture with other valid query parameters correctly' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg?hello=true&life=42' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50/photo.jpg?hello=true&life=42')
      end

      it 'should return the image with width and height specified in the `image_size` option' do
        @options = { image_size: { width: 50, height: 40 } }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/w50-h40/photo.jpg')
      end

      it 'should return square image when `image_aspect_ratio` is specified' do
        @options = { image_aspect_ratio: 'square' }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/c/photo.jpg')
      end

      it 'should return square sized image when `image_aspect_ratio` and `image_size` is set' do
        @options = { image_aspect_ratio: 'square', image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/s50-c/photo.jpg')
      end

      it 'should return square sized image when `image_aspect_ratio` and `image_size` has height and width' do
        @options = { image_aspect_ratio: 'square', image_size: { width: 50, height: 40 } }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/w50-h40-c/photo.jpg')
      end

      it 'should return original image if image url does not end in `photo.jpg`' do
        @options = { image_size: 50 }
        allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photograph.jpg' } }
        expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/photograph.jpg')
      end
    end

    it 'should return original image if no options are provided' do
      allow(subject).to receive(:raw_info) { { 'picture' => 'https://lh3.googleusercontent.com/url/photo.jpg' } }
      expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/photo.jpg')
    end

    it 'should return correct image if google image url has double https' do
      allow(subject).to receive(:raw_info) { { 'picture' => 'https:https://lh3.googleusercontent.com/url/photo.jpg' } }
      expect(subject.info[:image]).to eq('https://lh3.googleusercontent.com/url/photo.jpg')
    end
  end

  describe 'build_access_token' do
    it 'should use a hybrid authorization request_uri if this is an AJAX request with a code parameter' do
      allow(request).to receive(:xhr?).and_return(true)
      allow(request).to receive(:params).and_return('code' => 'valid_code')

      client = double(:client)
      auth_code = double(:auth_code)
      allow(client).to receive(:auth_code).and_return(auth_code)
      expect(subject).to receive(:client).and_return(client)
      expect(auth_code).to receive(:get_token).with('valid_code', { redirect_uri: 'postmessage' }, {})

      expect(subject).not_to receive(:orig_build_access_token)
      subject.build_access_token
    end

    it 'should use a hybrid authorization request_uri if this is an AJAX request (mobile) with a code parameter' do
      allow(request).to receive(:xhr?).and_return(true)
      allow(request).to receive(:params).and_return('code' => 'valid_code', 'redirect_uri' => '')

      client = double(:client)
      auth_code = double(:auth_code)
      allow(client).to receive(:auth_code).and_return(auth_code)
      expect(subject).to receive(:client).and_return(client)
      expect(auth_code).to receive(:get_token).with('valid_code', { redirect_uri: '' }, {})

      expect(subject).not_to receive(:orig_build_access_token)
      subject.build_access_token
    end

    it 'should use the request_uri from params if this not an AJAX request (request from installed app) with a code parameter' do
      allow(request).to receive(:xhr?).and_return(false)
      allow(request).to receive(:params).and_return('code' => 'valid_code', 'redirect_uri' => 'redirect_uri')

      client = double(:client)
      auth_code = double(:auth_code)
      allow(client).to receive(:auth_code).and_return(auth_code)
      expect(subject).to receive(:client).and_return(client)
      expect(auth_code).to receive(:get_token).with('valid_code', { redirect_uri: 'redirect_uri' }, {})

      expect(subject).not_to receive(:orig_build_access_token)
      subject.build_access_token
    end

    it 'should read access_token from hash if this is not an AJAX request with a code parameter' do
      allow(request).to receive(:xhr?).and_return(false)
      allow(request).to receive(:params).and_return('access_token' => 'valid_access_token')
      expect(subject).to receive(:verify_token).with('valid_access_token').and_return true
      expect(subject).to receive(:client).and_return(:client)

      token = subject.build_access_token
      expect(token).to be_instance_of(::OAuth2::AccessToken)
      expect(token.token).to eq('valid_access_token')
      expect(token.client).to eq(:client)
    end

    it 'should use callback_url without query_string if this is not an AJAX request' do
      allow(request).to receive(:xhr?).and_return(false)
      allow(request).to receive(:params).and_return('code' => 'valid_code')

      client = double(:client)
      auth_code = double(:auth_code)
      allow(client).to receive(:auth_code).and_return(auth_code)
      allow(subject).to receive(:callback_url).and_return('redirect_uri_without_query_string')

      expect(subject).to receive(:client).and_return(client)
      expect(auth_code).to receive(:get_token).with('valid_code', { redirect_uri: 'redirect_uri_without_query_string' }, {})
      subject.build_access_token
    end
  end

  describe 'verify_iss option' do
    before(:each) do
      subject.options.client_options[:connection_build] = proc do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/oauth2/v3/tokeninfo?access_token=invalid_iss_token') do
            [200, { 'Content-Type' => 'application/json; charset=UTF-8' },
             JSON.dump(
               aud: '000000000000.apps.googleusercontent.com',
               sub: '123456789',
               email_verified: 'true',
               email: 'example@example.com',
               access_type: 'offline',
               scope: 'profile email',
               expires_in: 436,
               iss: 'foobar.com'
             )]
          end
        end
      end
      subject.options.authorized_client_ids = ['000000000000.apps.googleusercontent.com']
      subject.options.client_id = '000000000000.apps.googleusercontent.com'
      subject.options[:verify_iss] = false
    end

    it 'should verify token if the iss does not match options.expected_iss' do
      result = subject.send(:verify_token, 'invalid_iss_token')
      expect(result).to eq(true)
    end
  end

  describe 'verify_token' do
    before(:each) do
      subject.options.client_options[:connection_build] = proc do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/oauth2/v3/tokeninfo?access_token=valid_access_token') do
            [200, { 'Content-Type' => 'application/json; charset=UTF-8' }, JSON.dump(
              aud: '000000000000.apps.googleusercontent.com',
              sub: '123456789',
              email_verified: 'true',
              email: 'example@example.com',
              access_type: 'offline',
              scope: 'profile email',
              expires_in: 436
            )]
          end
          stub.get('/oauth2/v3/tokeninfo?access_token=invalid_access_token') do
            [400, { 'Content-Type' => 'application/json; charset=UTF-8' }, JSON.dump(error_description: 'Invalid Value')]
          end
        end
      end
    end

    it 'should verify token if access_token is valid and app_id equals' do
      subject.options.client_id = '000000000000.apps.googleusercontent.com'
      expect(subject.send(:verify_token, 'valid_access_token')).to eq(true)
    end

    it 'should verify token if access_token is valid and app_id authorized' do
      subject.options.authorized_client_ids = ['000000000000.apps.googleusercontent.com']
      expect(subject.send(:verify_token, 'valid_access_token')).to eq(true)
    end

    it 'should not verify token if access_token is valid but app_id is false' do
      expect(subject.send(:verify_token, 'valid_access_token')).to eq(false)
    end

    it 'should raise error if access_token is invalid' do
      expect do
        subject.send(:verify_token, 'invalid_access_token')
      end.to raise_error(OAuth2::Error)
    end
  end

  describe 'verify_hd' do
    let(:client) do
      OAuth2::Client.new('abc', 'def') do |builder|
        builder.request :url_encoded
        builder.adapter :test do |stub|
          stub.get('/plus/v1/people/me/openIdConnect') do
            [200, { 'Content-Type' => 'application/json; charset=UTF-8' }, JSON.dump(
              hd: 'example.com'
            )]
          end
        end
      end
    end
    let(:access_token) { OAuth2::AccessToken.from_hash(client, {}) }

    context 'when domain is nil' do
      let(:client) do
        OAuth2::Client.new('abc', 'def') do |builder|
          builder.request :url_encoded
          builder.adapter :test do |stub|
            stub.get('/plus/v1/people/me/openIdConnect') do
              [200, { 'Content-Type' => 'application/json; charset=UTF-8' }, JSON.dump({})]
            end
          end
        end
      end

      it 'should verify hd if options hd is set and correct' do
        subject.options.hd = nil
        expect(subject.send(:verify_hd, access_token)).to eq(true)
      end

      it 'should verify hd if options hd is set as an array and is correct' do
        subject.options.hd = ['example.com', 'example.co', nil]
        expect(subject.send(:verify_hd, access_token)).to eq(true)
      end

      it 'should raise an exception if nil is not included' do
        subject.options.hd = ['example.com', 'example.co']
        expect do
          subject.send(:verify_hd, access_token)
        end.to raise_error(OmniAuth::Strategies::OAuth2::CallbackError)
      end
    end

    it 'should verify hd if options hd is not set' do
      expect(subject.send(:verify_hd, access_token)).to eq(true)
    end

    it 'should verify hd if options hd is set and correct' do
      subject.options.hd = 'example.com'
      expect(subject.send(:verify_hd, access_token)).to eq(true)
    end

    it 'should verify hd if options hd is set as an array and is correct' do
      subject.options.hd = ['example.com', 'example.co', nil]
      expect(subject.send(:verify_hd, access_token)).to eq(true)
    end

    it 'should verify hd if options hd is set as an Proc and is correct' do
      subject.options.hd = proc { 'example.com' }
      expect(subject.send(:verify_hd, access_token)).to eq(true)
    end

    it 'should verify hd if options hd is set as an Proc returning an array and is correct' do
      subject.options.hd = proc { ['example.com', 'example.co'] }
      expect(subject.send(:verify_hd, access_token)).to eq(true)
    end

    it 'should raise error if options hd is set and wrong' do
      subject.options.hd = 'invalid.com'
      expect do
        subject.send(:verify_hd, access_token)
      end.to raise_error(OmniAuth::Strategies::GoogleOauth2::CallbackError)
    end

    it 'should raise error if options hd is set as an array and is not correct' do
      subject.options.hd = ['invalid.com', 'invalid.co']
      expect do
        subject.send(:verify_hd, access_token)
      end.to raise_error(OmniAuth::Strategies::GoogleOauth2::CallbackError)
    end
  end
end
