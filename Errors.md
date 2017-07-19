# Common Errors

If you've encountered an error that's not listed here and was able to resolve it, please contribute to this document. It will help tons of people!

*NOTE:* Consider restarting your terminal if you're noticing multiple commands not working.

## Installation

### Ruby

#### Error

```
Ruby Bundle Symbol not found: _SSLv2_client_method (LoadError)
```

#### Fix

```
rvm get stable
```

```
rvm reinstall ruby
```

```
rvm gemset pristine
```

### Homebrew

#### Error

```
Requirements installation failed with status: 1. Failed to update Homebrew, follow instructions here: https://github.com/Homebrew/homebrew/wiki/Common-Issues and make sure brew update works before continuing.
```

Encountered while trying to run: `rvm install ruby-2.3.1`

#### Fix

Run `brew update`, this may lead to these errors:

Error: `Error: /usr/local must be writable!`

Fix: `sudo chown -R $(whoami) /usr/local`

Error: `Error: update-report should not be called directly!`

Fix: `brew doctor`

Error: `Warning: Your Xcode (8.0) is outdated. Please update to Xcode 8.2 (or delete it). Xcode can be updated from the App Store.`

Fix: `xcode-select --install`

### RVM and Gems

#### Error

```
ERROR: While executing gem ... (Gem::RemoteFetcher::FetchError) SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (https://api.rubygems.org/specs.4.8.gz)
```

Encountering errors while trying to run:
```
gem update --system
```
```
gem update
```

#### Fix

```
rvm use ruby-2.3.1@rails4.2.9 --create`
```

### libv8 and therubyracer (macOS 10.11+)

* libv8: https://github.com/cowboyd/libv8/issues/205
* therubyracer:
 http://stackoverflow.com/questions/33475709/install-therubyracer-gem-on-osx-10-11-el-capitan
  https://github.com/cowboyd/therubyracer/issues/359

### SSL (Windows)

#### Error

```
SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed
```

#### Fix

Download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

### PostgreSQL Bad Connection

#### Error

```
PG::ConnectionBad (fe_sendauth: no password supplied )
```

#### Fix

You may need to create a new PSQL user. Follow this [guide](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04) to define a username and password.

To keep this information private, list `PSQL_USERNAME` and `PSQL_PASSWORD` under `config/env/test.env` and `config/env/development.env`.

### PostgreSQL Incompatible Version

#### Error

```
FATAL:  database files are incompatible with server
DETAIL:  The data directory was initialized by PostgreSQL version 9.4, which is not compatible with this version 9.6.1.
```

#### Fix

1) `brew install postgresql@9.4`
2) `brew services start postgresql@9.4`
3) Stop the server by running `brew services stop postgresql@9.4`.

## Testing

### Test Database Doesn't exist

#### Error

```
FATAL:  database "ifme_test" does not exist
```

#### Fix

```
bin/rake db:create db:migrate RAILS_ENV=test
```
