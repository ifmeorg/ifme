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

require 'googleauth/scope_util'

describe Google::Auth::ScopeUtil do
  shared_examples 'normalizes scopes' do
    let(:normalized) { Google::Auth::ScopeUtil.normalize(source) }

    it 'normalizes the email scope' do
      expect(normalized).to include(
        'https://www.googleapis.com/auth/userinfo.email'
      )
      expect(normalized).to_not include 'email'
    end

    it 'normalizes the profile scope' do
      expect(normalized).to include(
        'https://www.googleapis.com/auth/userinfo.profile'
      )
      expect(normalized).to_not include 'profile'
    end

    it 'normalizes the openid scope' do
      expect(normalized).to include 'https://www.googleapis.com/auth/plus.me'
      expect(normalized).to_not include 'openid'
    end

    it 'leaves other other scopes as-is' do
      expect(normalized).to include 'https://www.googleapis.com/auth/drive'
    end
  end

  context 'with scope as string' do
    let(:source) do
      'email profile openid https://www.googleapis.com/auth/drive'
    end
    it_behaves_like 'normalizes scopes'
  end

  context 'with scope as Array' do
    let(:source) do
      %w(email profile openid https://www.googleapis.com/auth/drive)
    end
    it_behaves_like 'normalizes scopes'
  end
end
