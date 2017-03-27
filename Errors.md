# Possible Errors
If you are encountering an error that is not listed and have figured out how to resolve, please contribute to this document.

NOTE: If a command is not working and
  - you are using multiple terminal windows OR
  - you are using one terminal window and prior installation step was successful

please close all terminal windows (after the process has not running) and reopen.

## Installation

### Ruby

##### ERROR: `Ruby Bundle Symbol not found: _SSLv2_client_method (LoadError)`

TO FIX:

```
rvm get stable
```

```
rvm reinstall ruby
```

```
rvm gemset pristine
```

##### ERROR: `Requirements installation failed with status: 1.`
`Failed to update Homebrew, follow instructions here:
    https://github.com/Homebrew/homebrew/wiki/Common-Issues
and make sure `brew update` works before continuing.\n`

encountered while trying to attempt `rvm install ruby-2.3.1`

TO FIX: `brew update`
which may lead to these errors:

###### ERROR: `Error: /usr/local must be writable!`
TO FIX: `sudo chown -R $(whoami) /usr/local`
This will also prompt you for your password

###### ERROR: `Error: update-report should not be called directly!`
TO FIX: `brew doctor`
to may lead to this warning:
`Warning: Your Xcode (8.0) is outdated.
Please update to Xcode 8.2 (or delete it).
Xcode can be updated from the App Store.`

TO FIX: `xcode-select --install`

### libv8 and therubyracer (macOS 10.11+)

* libv8: https://github.com/cowboyd/libv8/issues/205
* therubyracer: http://stackoverflow.com/questions/33475709/install-therubyracer-gem-on-osx-10-11-el-capitan, https://github.com/cowboyd/therubyracer/issues/359

### SSL (Windows)

##### ERROR: `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`

TO FIX: download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

## Configuration

## Testing

-------------------------------------

Encountering errors while trying to run
gem update --system
gem update

Error: ERROR:  While executing gem ... (Gem::RemoteFetcher::FetchError)
    SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (https://api.rubygems.org/specs.4.8.gz)

To fix:
rvm use ruby-2.3.1@rails4.2.6 --create


---------
On macOS, if you run into nokogiri errors run `xcode-select --install`



## Possible Errors

### Postgres

```
PG::ConnectionBad (fe_sendauth: no password supplied )
```

You may need to create a new PSQL user. Follow this [guide](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04) to define a username and password.

To keep this information private, list `PSQL_USERNAME` and `PSQL_PASSWORD` under `config/env/test.env` and `config/env/development.env`, then add username and password to `config/database.yml`:

```
development: &default
  ...
  username: <%= ENV["PSQL_USERNAME"] %>
  password: <%= ENV["PSQL_PASSWORD"] %>
```


Testing rspec
If you receive an error for having `'FATAL:  database "ifme_test" does not exist'`, run the following.

```
bin/rake db:create db:migrate RAILS_ENV=test
```
