# Copyright 2015, Google Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are
# met:
#
#     * Redistributions of source code must retain the above copyright
# notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above
# copyright notice, this list of conditions and the following disclaimer
# in the documentation and/or other materials provided with the
# distribution.
#     * Neither the name of Google Inc. nor the names of its
# contributors may be used to endorse or promote products derived from
# this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
# OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
# SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
# LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

spec_dir = File.expand_path(File.join(File.dirname(__FILE__)))
$LOAD_PATH.unshift(spec_dir)
$LOAD_PATH.uniq!

require 'apply_auth_examples'
require 'fakefs/safe'
require 'fileutils'
require 'googleauth/user_refresh'
require 'jwt'
require 'multi_json'
require 'openssl'
require 'spec_helper'
require 'tmpdir'

include Google::Auth::CredentialsLoader

describe Google::Auth::UserRefreshCredentials do
  UserRefreshCredentials = Google::Auth::UserRefreshCredentials

  let(:cred_json) do
    {
      client_secret: 'privatekey',
      client_id: 'client123',
      refresh_token: 'refreshtoken',
      type: 'authorized_user'
    }
  end

  before(:example) do
    @key = OpenSSL::PKey::RSA.new(2048)
    @client = UserRefreshCredentials.make_creds(
      json_key_io: StringIO.new(cred_json_text),
      scope: 'https://www.googleapis.com/auth/userinfo.profile'
    )
  end

  def make_auth_stubs(opts = {})
    access_token = opts[:access_token] || ''
    body = MultiJson.dump('access_token' => access_token,
                          'token_type' => 'Bearer',
                          'expires_in' => 3600)
    stub_request(:post, 'https://www.googleapis.com/oauth2/v4/token')
      .with(body: hash_including('grant_type' => 'refresh_token'))
      .to_return(body: body,
                 status: 200,
                 headers: { 'Content-Type' => 'application/json' })
  end

  def cred_json_text(missing = nil)
    cred_json.delete(missing.to_sym) unless missing.nil?
    MultiJson.dump(cred_json)
  end

  it_behaves_like 'apply/apply! are OK'

  describe '#from_env' do
    before(:example) do
      @var_name = ENV_VAR
      @credential_vars = [
        ENV_VAR, CLIENT_ID_VAR, CLIENT_SECRET_VAR, REFRESH_TOKEN_VAR,
        ACCOUNT_TYPE_VAR
      ]
      @original_env_vals = {}
      @credential_vars.each { |var| @original_env_vals[var] = ENV[var] }
      @scope = 'https://www.googleapis.com/auth/userinfo.profile'
      @clz = UserRefreshCredentials
    end

    after(:example) do
      @credential_vars.each { |var| ENV[var] = @original_env_vals[var] }
    end

    it 'returns nil if the GOOGLE_APPLICATION_CREDENTIALS is unset' do
      ENV.delete(@var_name) unless ENV[@var_name].nil?
      expect(UserRefreshCredentials.from_env(@scope)).to be_nil
    end

    it 'fails if the GOOGLE_APPLICATION_CREDENTIALS path does not exist' do
      ENV.delete(@var_name) unless ENV[@var_name].nil?
      expect(UserRefreshCredentials.from_env(@scope)).to be_nil
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, 'does-not-exist')
        ENV[@var_name] = key_path
        expect { @clz.from_env(@scope) }.to raise_error RuntimeError
      end
    end

    it 'fails if the GOOGLE_APPLICATION_CREDENTIALS path file is invalid' do
      needed = %w(client_id client_secret refresh_token)
      needed.each do |missing|
        Dir.mktmpdir do |dir|
          key_path = File.join(dir, 'my_cert_file')
          FileUtils.mkdir_p(File.dirname(key_path))
          File.write(key_path, cred_json_text(missing))
          ENV[@var_name] = key_path
          expect { @clz.from_env(@scope) }.to raise_error RuntimeError
        end
      end
    end

    it 'succeeds when the GOOGLE_APPLICATION_CREDENTIALS file is valid' do
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, 'my_cert_file')
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV[@var_name] = key_path
        expect(@clz.from_env(@scope)).to_not be_nil
      end
    end

    it 'succeeds when GOOGLE_CLIENT_ID, GOOGLE_CLIENT_SECRET, and '\
      'GOOGLE_REFRESH_TOKEN env vars are valid' do
      ENV[CLIENT_ID_VAR] = cred_json[:client_id]
      ENV[CLIENT_SECRET_VAR] = cred_json[:client_secret]
      ENV[REFRESH_TOKEN_VAR] = cred_json[:refresh_token]
      ENV[ACCOUNT_TYPE_VAR] = cred_json[:type]
      creds = @clz.from_env(@scope)
      expect(creds).to_not be_nil
      expect(creds.client_id).to eq(cred_json[:client_id])
      expect(creds.client_secret).to eq(cred_json[:client_secret])
      expect(creds.refresh_token).to eq(cred_json[:refresh_token])
    end
  end

  describe '#from_well_known_path' do
    before(:example) do
      @home = ENV['HOME']
      @scope = 'https://www.googleapis.com/auth/userinfo.profile'
      @known_path = WELL_KNOWN_PATH
      @clz = UserRefreshCredentials
    end

    after(:example) do
      ENV['HOME'] = @home unless @home == ENV['HOME']
    end

    it 'is nil if no file exists' do
      ENV['HOME'] = File.dirname(__FILE__)
      expect(UserRefreshCredentials.from_well_known_path(@scope)).to be_nil
    end

    it 'fails if the file is invalid' do
      needed = %w(client_id client_secret refresh_token)
      needed.each do |missing|
        Dir.mktmpdir do |dir|
          key_path = File.join(dir, '.config', @known_path)
          FileUtils.mkdir_p(File.dirname(key_path))
          File.write(key_path, cred_json_text(missing))
          ENV['HOME'] = dir
          expect { @clz.from_well_known_path(@scope) }
            .to raise_error RuntimeError
        end
      end
    end

    it 'successfully loads the file when it is present' do
      Dir.mktmpdir do |dir|
        key_path = File.join(dir, '.config', @known_path)
        FileUtils.mkdir_p(File.dirname(key_path))
        File.write(key_path, cred_json_text)
        ENV['HOME'] = dir
        expect(@clz.from_well_known_path(@scope)).to_not be_nil
      end
    end
  end

  describe '#from_system_default_path' do
    before(:example) do
      @scope = 'https://www.googleapis.com/auth/userinfo.profile'
      @path = File.join('/etc/google/auth/', CREDENTIALS_FILE_NAME)
      @clz = UserRefreshCredentials
    end

    it 'is nil if no file exists' do
      FakeFS do
        expect(UserRefreshCredentials.from_system_default_path(@scope))
          .to be_nil
      end
    end

    it 'fails if the file is invalid' do
      needed = %w(client_id client_secret refresh_token)
      needed.each do |missing|
        FakeFS do
          FileUtils.mkdir_p(File.dirname(@path))
          File.write(@path, cred_json_text(missing))
          expect { @clz.from_system_default_path(@scope) }
            .to raise_error RuntimeError
          File.delete(@path)
        end
      end
    end

    it 'successfully loads the file when it is present' do
      FakeFS do
        FileUtils.mkdir_p(File.dirname(@path))
        File.write(@path, cred_json_text)
        expect(@clz.from_system_default_path(@scope)).to_not be_nil
        File.delete(@path)
      end
    end
  end

  shared_examples 'revoked token' do
    it 'should nil the refresh token' do
      expect(@client.refresh_token).to be_nil
    end

    it 'should nil the access token' do
      expect(@client.access_token).to be_nil
    end

    it 'should mark the token as expired' do
      expect(@client.expired?).to be_truthy
    end
  end

  describe 'when revoking a refresh token' do
    let(:stub) do
      stub_request(:get, 'https://accounts.google.com/o/oauth2/revoke' \
                         '?token=refreshtoken')
        .to_return(status: 200,
                   headers: { 'Content-Type' => 'application/json' })
    end

    before(:example) do
      stub
      @client.revoke!
    end

    it_behaves_like 'revoked token'
  end

  describe 'when revoking an access token' do
    let(:stub) do
      stub_request(:get, 'https://accounts.google.com/o/oauth2/revoke' \
                         '?token=accesstoken')
        .to_return(status: 200,
                   headers: { 'Content-Type' => 'application/json' })
    end

    before(:example) do
      stub
      @client.refresh_token = nil
      @client.access_token = 'accesstoken'
      @client.revoke!
    end

    it_behaves_like 'revoked token'
  end

  describe 'when revoking an invalid token' do
    let(:stub) do
      stub_request(:get, 'https://accounts.google.com/o/oauth2/revoke' \
                         '?token=refreshtoken')
        .to_return(status: 400,
                   headers: { 'Content-Type' => 'application/json' })
    end

    it 'raises an authorization error' do
      stub
      expect { @client.revoke! }.to raise_error(
        Signet::AuthorizationError
      )
    end
  end

  describe 'when erros occurred with request' do
    it 'should fail with Signet::AuthorizationError if request times out' do
      allow_any_instance_of(Faraday::Connection).to receive(:get)
        .and_raise(Faraday::TimeoutError)
      expect { @client.revoke! }
        .to raise_error Signet::AuthorizationError
    end

    it 'should fail with Signet::AuthorizationError if request fails' do
      allow_any_instance_of(Faraday::Connection).to receive(:get)
        .and_raise(Faraday::ConnectionFailed, nil)
      expect { @client.revoke! }
        .to raise_error Signet::AuthorizationError
    end
  end
end
