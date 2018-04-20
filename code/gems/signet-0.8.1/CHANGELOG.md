## 0.8.1 (2017-10-13)

* Restore support for Ruby 1.9.3

## 0.8.0 (2017-10-12)

* Ensure the "expires_at" attribute is recalculated on refresh (chutzimir)
* Fix warnings on Ruby 2.4 (koic)
* Allow DateTime objects to be passed into attributes (foxtacles)
* Provide signature verification algorithm for compatibility with ruby-jwt 2.0 (jurriaan)
* Signet::OAuth2::Client#decoded_id_token can take a keyfinder block (mvastola)

## 0.7.3 (2016-06-20)

* Fix timestamp parsing on 32-bit systems
* Fix expiration check when issue/expiry times are nil

## 0.7.2 (2015-12-21)

* Don't assume Faraday form encoding middleware is present

## 0.7.1 (2015-12-17)

* Fix an issue with date parsing

## 0.7 (2015-12-06)

* No longer overwrite SSL environment variables.
* Tighten up date & URL (de)serialization for OAuth2 client
* Allow Hurley as a connection
* Allow scope as an option in `fetch_access_token!` to request downscoped access tokens
* Add expires_within(sec) method to oauth2 client to facilitate proactive
  refreshes

## 0.6.1 (2015-06-08)

* Fix language warnings for unused & shadowed variables ((@blowmage)[])
* Update SSL cert path for OSX ((@gambaroff)[])
* Update JWT library and fix broken tests
* Fix incorrect parameter name in OAuth2 client docs ((@samuelreh)[])
* Fix symbolization of URL parameter keys ((@swifthand)[])

## 0.6.0 (2014-12-05)

* Drop support for ruby versions < 1.9.3
* Update gem dependencies and lock down versions tighter
* Allow form encoded responses when exchanging OAuth 2 authorization codes
* Normalize options keys for indifferent access

## 0.5.1 (2014-06-08)

* Allow Hash objects to be used to initialize authorization URI
* Added PLAINTEXT and RSA-SHA1 signature methods to OAuth 1 support
* Added client object serialization
* The `approval_prompt` option no longer defaults to `:force`
* The `approval_prompt` and `prompt` are now mutually exclusive.

## 0.5.0 (2013-05-31)

* Switched to faraday 0.9.0
* Added `expires_at` option

## 0.4.5

* Minor documentation fixes
* Allow postmessage as a valid redirect_uri in OAuth 2

## 0.4.4

* Add support for assertion profile

## 0.4.3

* Added method to clear credentials

## 0.4.2

* Backwards compatibility for MultiJson

## 0.4.1

* Updated Launchy dependency

## 0.4.0

* Added OAuth 1 server implementation
* Updated Faraday dependency

## 0.3.4

* Attempts to auto-detect CA cert location

## 0.3.3

* Request objects no longer recreated during processing
* Faraday middleware now supported
* Streamed requests now supported
* Fixed assertion profiles; client ID/secret omission no longer an error

## 0.3.2

* Added audience security check for ID tokens

## 0.3.1

* Fixed a warning while determining grant type
* Removed requirement that a connection be supplied when authorizing requests
* Updated addressable dependency to avoid minor bug
* Fixed some documentation stuff around markdown formatting
* Added support for Google Code wiki format output when generating docs

## 0.3.0

* Replaced httpadapter gem dependency with faraday
* Replaced json gem dependency with multi_json
* Updated to OAuth 2.0 draft 22
* Complete test coverage

## 0.2.4

* Updated to incorporate changes to the Google OAuth endpoints

## 0.2.3

* Added support for JWT-formatted ID tokens.
* Added :issued_at option to #update_token! method.

## 0.2.2

* Lowered requirements for json gem

## 0.2.1

* Updated to keep in sync with the new httpadapter changes

## 0.2.0

* Added support for OAuth 2.0 draft 10

## 0.1.4

* Added support for a two-legged authorization flow

## 0.1.3

* Fixed issue with headers passed in as a Hash
* Fixed incompatibilities with Ruby 1.8.6

## 0.1.2

* Fixed bug with overzealous normalization

## 0.1.1

* Fixed bug with missing StringIO require
* Fixed issue with dependency on unreleased features of addressable

## 0.1.0

* Initial release
