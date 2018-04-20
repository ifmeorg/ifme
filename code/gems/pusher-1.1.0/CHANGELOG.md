
1.1.0 / 2016-05-20
==================

  * Add support for batch events

1.0.0 / 2016-05-19
==================

No breaking changes, this release is just to follow semver and show that we
are stable.

0.18.0 / 2016-05-15
==================

  * Introduce `Pusher::Client.from_env`
  * Improve error handling on missing config

0.17.0 / 2016-02-22
==================

  * Introduce the `cluster` option.

0.16.0 / 2016-01-21
==================

  * Bump httpclient version to 2.7
  * Ruby 1.8.7 is not supported anymore.

0.15.2 / 2015-12-03
==================

  * Documented `Pusher.channel_info`, `Pusher.channels`
  * Added `Pusher.channel_users`

0.15.1 / 2015-11-03
==================

  * Fixed a bug where the `authenticate` method added in 0.15.0 wasn't exposed on the Pusher class.

0.15.0 / 2015-11-02
==================

  * Added `Pusher.authenticate` method for authenticating private and presence channels.
    This is prefered over the older `Pusher['a_channel'].authenticate(...)` style.

0.14.6 / 2015-09-29
==================
  * Updated to use the `pusher-signature` gem instead of `signature`.
    This resolves namespace related issues.

0.14.5 / 2015-05-11
==================

  * SECURITY: Prevent auth delegation trough crafted socket IDs

0.14.4 / 2015-01-20
==================

  * SECURITY: Prevent timing attack, update signature to v0.1.8
  * SECURITY: Prevent POODLE. Disable SSLv3, update httpclient to v2.5
  * Fix channel name character limit.
  * Adds support for listing users on a presence channel

0.14.3 / 2015-01-20
==================

Yanked, bad release

0.14.2 / 2014-10-16
==================

First release with a changelog !

  * Bump httpclient to v2.4. See #62 (POODLE SSL)
  * Fix limited channel count at README.md. Thanks @tricknotes

