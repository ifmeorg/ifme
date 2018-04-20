## 0.6.1 (2017/10/18)

* Fix file permissions

## 0.6.0 (2017/10/17)

### Changes

* Support ruby-jwt 2.0
* Add simple credentials class

## 0.5.3 (2017/07/21)

### Changes

* Fix file permissions on the gem's `.rb` files.

## 0.5.2 (2017/07/19)

### Changes

* Add retry mechanism when fetching access tokens in `GCECredentials` and `UserRefreshCredentials` classes.
* Update Google API OAuth2 token credential URI to v4.

## 0.5.1 (2016/01/06)

### Changes

* Change header name emitted by `Client#apply` from "Authorization" to "authorization" ([@murgatroid99][])
* Fix ADC not working on some windows machines ([@vsubramani][])
[#55](https://github.com/google/google-auth-library-ruby/issues/55)

## 0.5.0 (2015/10/12)

### Changes

* Initial support for user credentials ([@sqrrrl][])
* Update Signet to 0.7

## 0.4.2 (2015/08/05)

### Changes

* Updated UserRefreshCredentials hash to use string keys ([@haabaato][])
[#36](https://github.com/google/google-auth-library-ruby/issues/36)

* Add support for a system default credentials file. ([@mr-salty][])
[#33](https://github.com/google/google-auth-library-ruby/issues/33)

* Fix bug when loading credentials from ENV ([@dwilkie][])
[#31](https://github.com/google/google-auth-library-ruby/issues/31)

* Relax the constraint of dependent version of multi_json ([@igrep][])
[#30](https://github.com/google/google-auth-library-ruby/issues/30)

### Changes

* Enables passing credentials via environment variables. ([@haabaato][])
[#27](https://github.com/google/google-auth-library-ruby/issues/27)

## 0.4.1 (2015/04/25)

### Changes

* Improves handling of --no-scopes GCE authorization ([@tbetbetbe][])
* Refactoring and cleanup ([@joneslee85][])

## 0.4.0 (2015/03/25)

### Changes

* Adds an implementation of JWT header auth ([@tbetbetbe][])

## 0.3.0 (2015/03/23)

### Changes

* makes the scope parameter's optional in all APIs. ([@tbetbetbe][])
* changes the scope parameter's position in various constructors. ([@tbetbetbe][])

[@dwilkie]: https://github.com/dwilkie
[@haabaato]: https://github.com/haabaato
[@igrep]: https://github.com/igrep
[@joneslee85]: https://github.com/joneslee85
[@mr-salty]: https://github.com/mr-salty
[@tbetbetbe]: https://github.com/tbetbetbe
[@murgatroid99]: https://github.com/murgatroid99
[@vsubramani]: https://github.com/vsubramani
