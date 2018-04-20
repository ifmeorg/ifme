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
require 'googleauth/signet'
require 'jwt'
require 'openssl'
require 'spec_helper'

describe Signet::OAuth2::Client do
  before(:example) do
    @key = OpenSSL::PKey::RSA.new(2048)
    @client = Signet::OAuth2::Client.new(
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: 'https://www.googleapis.com/auth/userinfo.profile',
      issuer: 'app@example.com',
      audience: 'https://accounts.google.com/o/oauth2/token',
      signing_key: @key
    )
  end

  def make_auth_stubs(opts)
    access_token = opts[:access_token] || ''
    body = MultiJson.dump('access_token' => access_token,
                          'token_type' => 'Bearer',
                          'expires_in' => 3600)
    blk = proc do |request|
      params = Addressable::URI.form_unencode(request.body)
      _claim, _header = JWT.decode(params.assoc('assertion').last,
                                   @key.public_key, true,
                                   algorithm: 'RS256')
    end
    stub_request(:post, 'https://accounts.google.com/o/oauth2/token')
      .with(body: hash_including(
        'grant_type' => 'urn:ietf:params:oauth:grant-type:jwt-bearer'
      ), &blk)
      .to_return(body: body,
                 status: 200,
                 headers: { 'Content-Type' => 'application/json' })
  end

  it_behaves_like 'apply/apply! are OK'
end
