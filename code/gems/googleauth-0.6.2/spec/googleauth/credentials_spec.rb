# Copyright 2017, Google Inc.
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

require 'googleauth'

# This test is testing the private class Google::Auth::Credentials. We want to
# make sure that the passed in scope propogates to the Signet object. This means
# testing the private API, which is generally frowned on.
describe Google::Auth::Credentials, :private do
  let(:default_keyfile_hash) do
    {
      'private_key_id' => 'testabc1234567890xyz',
      'private_key' => "-----BEGIN RSA PRIVATE KEY-----\nMIIBOwIBAAJBAOyi0Hy1l4Ym2m2o71Q0TF4O9E81isZEsX0bb+Bqz1SXEaSxLiXM\nUZE8wu0eEXivXuZg6QVCW/5l+f2+9UPrdNUCAwEAAQJAJkqubA/Chj3RSL92guy3\nktzeodarLyw8gF8pOmpuRGSiEo/OLTeRUMKKD1/kX4f9sxf3qDhB4e7dulXR1co/\nIQIhAPx8kMW4XTTL6lJYd2K5GrH8uBMp8qL5ya3/XHrBgw3dAiEA7+3Iw3ULTn2I\n1J34WlJ2D5fbzMzB4FAHUNEV7Ys3f1kCIQDtUahCMChrl7+H5t9QS+xrn77lRGhs\nB50pjvy95WXpgQIhAI2joW6JzTfz8fAapb+kiJ/h9Vcs1ZN3iyoRlNFb61JZAiA8\nNy5NyNrMVwtB/lfJf1dAK/p/Bwd8LZLtgM6PapRfgw==\n-----END RSA PRIVATE KEY-----\n",
      'client_email' => 'credz-testabc1234567890xyz@developer.gserviceaccount.com',
      'client_id' => 'credz-testabc1234567890xyz.apps.googleusercontent.com',
      'type' => 'service_account'
    }
  end

  it 'uses a default scope' do
    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq([])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    Google::Auth::Credentials.new default_keyfile_hash
  end

  it 'uses a custom scope' do
    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    Google::Auth::Credentials.new default_keyfile_hash, scope: 'http://example.com/scope'
  end

  it 'can be subclassed to pass in other env paths' do
    TEST_PATH_ENV_VAR = 'TEST_PATH'.freeze
    TEST_PATH_ENV_VAL = '/unknown/path/to/file.txt'.freeze
    TEST_JSON_ENV_VAR = 'TEST_JSON_VARS'.freeze

    ENV[TEST_PATH_ENV_VAR] = TEST_PATH_ENV_VAL
    ENV[TEST_JSON_ENV_VAR] = JSON.generate(default_keyfile_hash)

    class TestCredentials < Google::Auth::Credentials
      SCOPE = 'http://example.com/scope'.freeze
      PATH_ENV_VARS = [TEST_PATH_ENV_VAR].freeze
      JSON_ENV_VARS = [TEST_JSON_ENV_VAR].freeze
    end

    allow(::File).to receive(:file?).with(TEST_PATH_ENV_VAL) { false }

    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    creds = TestCredentials.default
    expect(creds).to be_a_kind_of(TestCredentials)
    expect(creds.client).to eq(mocked_signet)
  end

  it 'subclasses can use PATH_ENV_VARS to get keyfile path' do
    class TestCredentials < Google::Auth::Credentials
      SCOPE = 'http://example.com/scope'.freeze
      PATH_ENV_VARS = ['PATH_ENV_DUMMY', 'PATH_ENV_TEST'].freeze
      JSON_ENV_VARS = ['JSON_ENV_DUMMY'].freeze
      DEFAULT_PATHS = ['~/default/path/to/file.txt'].freeze
    end

    allow(::ENV).to receive(:[]).with('PATH_ENV_DUMMY') { '/fake/path/to/file.txt' }
    allow(::File).to receive(:file?).with('/fake/path/to/file.txt') { false }
    allow(::ENV).to receive(:[]).with('PATH_ENV_TEST') { '/unknown/path/to/file.txt' }
    allow(::File).to receive(:file?).with('/unknown/path/to/file.txt') { true }
    allow(::File).to receive(:read).with('/unknown/path/to/file.txt') { JSON.generate(default_keyfile_hash) }

    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    creds = TestCredentials.default
    expect(creds).to be_a_kind_of(TestCredentials)
    expect(creds.client).to eq(mocked_signet)
  end

  it 'subclasses can use JSON_ENV_VARS to get keyfile contents' do
    class TestCredentials < Google::Auth::Credentials
      SCOPE = 'http://example.com/scope'.freeze
      PATH_ENV_VARS = ['PATH_ENV_DUMMY'].freeze
      JSON_ENV_VARS = ['JSON_ENV_DUMMY', 'JSON_ENV_TEST'].freeze
      DEFAULT_PATHS = ['~/default/path/to/file.txt'].freeze
    end

    allow(::ENV).to receive(:[]).with('PATH_ENV_DUMMY') { '/fake/path/to/file.txt' }
    allow(::File).to receive(:file?).with('/fake/path/to/file.txt') { false }
    allow(::ENV).to receive(:[]).with('JSON_ENV_DUMMY') { nil }
    allow(::ENV).to receive(:[]).with('JSON_ENV_TEST') { JSON.generate(default_keyfile_hash) }

    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    creds = TestCredentials.default
    expect(creds).to be_a_kind_of(TestCredentials)
    expect(creds.client).to eq(mocked_signet)
  end

  it 'subclasses can use DEFAULT_PATHS to get keyfile path' do
    class TestCredentials < Google::Auth::Credentials
      SCOPE = 'http://example.com/scope'.freeze
      PATH_ENV_VARS = ['PATH_ENV_DUMMY'].freeze
      JSON_ENV_VARS = ['JSON_ENV_DUMMY'].freeze
      DEFAULT_PATHS = ['~/default/path/to/file.txt'].freeze
    end

    allow(::ENV).to receive(:[]).with('PATH_ENV_DUMMY') { '/fake/path/to/file.txt' }
    allow(::File).to receive(:file?).with('/fake/path/to/file.txt') { false }
    allow(::ENV).to receive(:[]).with('JSON_ENV_DUMMY') { nil }
    allow(::File).to receive(:file?).with('~/default/path/to/file.txt') { true }
    allow(::File).to receive(:read).with('~/default/path/to/file.txt') { JSON.generate(default_keyfile_hash) }

    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    creds = TestCredentials.default
    expect(creds).to be_a_kind_of(TestCredentials)
    expect(creds.client).to eq(mocked_signet)
  end

  it 'subclasses that find no matches default to Google::Auth.get_application_default' do
    class TestCredentials < Google::Auth::Credentials
      SCOPE = 'http://example.com/scope'.freeze
      PATH_ENV_VARS = ['PATH_ENV_DUMMY'].freeze
      JSON_ENV_VARS = ['JSON_ENV_DUMMY'].freeze
      DEFAULT_PATHS = ['~/default/path/to/file.txt'].freeze
    end

    allow(::ENV).to receive(:[]).with('PATH_ENV_DUMMY') { '/fake/path/to/file.txt' }
    allow(::File).to receive(:file?).with('/fake/path/to/file.txt') { false }
    allow(::ENV).to receive(:[]).with('JSON_ENV_DUMMY') { nil }
    allow(::File).to receive(:file?).with('~/default/path/to/file.txt') { false }

    mocked_signet = double('Signet::OAuth2::Client')
    allow(mocked_signet).to receive(:fetch_access_token!).and_return(true)
    allow(Google::Auth).to receive(:get_application_default) do |scope|
      expect(scope).to eq(TestCredentials::SCOPE)

      # This should really be a Signet::OAuth2::Client object,
      # but mocking is making that difficult, so return a valid hash instead.
      default_keyfile_hash
    end
    allow(Signet::OAuth2::Client).to receive(:new) do |options|
      expect(options[:token_credential_uri]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:audience]).to eq('https://accounts.google.com/o/oauth2/token')
      expect(options[:scope]).to eq(['http://example.com/scope'])
      expect(options[:issuer]).to eq(default_keyfile_hash['client_email'])
      expect(options[:signing_key]).to be_a_kind_of(OpenSSL::PKey::RSA)

      mocked_signet
    end

    creds = TestCredentials.default
    expect(creds).to be_a_kind_of(TestCredentials)
    expect(creds.client).to eq(mocked_signet)
  end
end
