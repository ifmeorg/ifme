# Signet

<dl>
  <dt>Homepage</dt><dd><a href="http://code.google.com/p/oauth-signet/">http://code.google.com/p/oauth-signet/</a></dd>
  <dt>Author</dt><dd><a href="mailto:bobaman@google.com">Bob Aman</a></dd>
  <dt>Copyright</dt><dd>Copyright © 2010 Google, Inc.</dd>
  <dt>License</dt><dd>Apache 2.0</dd>
</dl>

[![Build Status](https://secure.travis-ci.org/google/signet.png)](http://travis-ci.org/google/signet)
[![Dependency Status](https://gemnasium.com/google/signet.png)](https://gemnasium.com/google/signet)

## Description

Signet is an OAuth 1.0 / OAuth 2.0 implementation.

## Reference

- {Signet::OAuth1}
- {Signet::OAuth1::Client}
- {Signet::OAuth1::Credential}
- {Signet::OAuth1::Server}
- {Signet::OAuth2}
- {Signet::OAuth2::Client}

## Example Usage for Google

# Initialize the client

``` ruby
require 'signet/oauth_2/client'
client = Signet::OAuth2::Client.new(
  :authorization_uri => 'https://accounts.google.com/o/oauth2/auth',
  :token_credential_uri =>  'https://www.googleapis.com/oauth2/v3/token',
  :client_id => '44410190108-74nkm6jc5e3vvjqis803frkvmu88cu3a.apps.googleusercontent.com',
  :client_secret => 'X1NUhvO-rQr9sm8uUSMY8i7v',
  :scope => 'email profile',
  :redirect_uri => 'https://example.client.com/oauth'
)
```

# Request an authorization code

```
redirect_to(client.authorization_uri)
```

# Obtain an access token

```
client.code = request.query['code']
client.fetch_access_token!
```

## Install

`gem install signet`

Be sure `https://rubygems.org` is in your gem sources.
