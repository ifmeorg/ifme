The steps below should be straightforward for Linux and OSX users. Windows users please refer to this [guide](https://gist.github.com/KelseyDH/11198922) for tips on setup.

#### Ruby on Rails

http://installrails.com

##### Updating existing Ruby installation

###### RVM

Assuming you have [RVM](https://rvm.io/rvm/install) installed, update to the latest version

```
rvm get stable --autolibs=enable
```

Close and re-open the terminal window

```
rvm install ruby-2.3.1
```

Check that Ruby has been updated by running `ruby -v`.

###### rbenv

Follow instructions for updating rbenv at the project's [GitHub](https://github.com/rbenv/rbenv). Make sure you also upgrade `ruby-build` if you used Homebrew to install rbenv.

Run the following to install Ruby 2.3.1:

```
rbenv install 2.3.1
```

Once you have cloned the project, set the local Ruby version to 2.3.1:

```
cd ifme
rbenv local 2.3.1
```

###### After updating or installing Ruby

Update the gem manager by running `gem update --system`.

Update your gems by running `gem update`.

If you are missing `bundler` and `nokogiri`, please install them

```
gem install bundler
```

```
gem install nokogiri
```

Make a gemset for the specific Ruby on Rails version (RVM)

```
rvm use ruby-2.3.1@rails4.2.6 --create
```

If you want to create a gemset using rbenv, you can install [rbenv-gemset](https://github.com/jf/rbenv-gemset)

##### Updating existing Rails installation

```
gem install rails --version=4.2.6
```

Check that Rails has been updated by running `rails -v`.

### Possible Errors

#### Ruby

If `Ruby Bundle Symbol not found: _SSLv2_client_method (LoadError)` is encountered, try running the following commands.

```
rvm get stable
```

```
rvm reinstall ruby
```

```
rvm gemset pristine
```

#### libv8 and therubyracer

If using El Captian OS X 10.11+ and there are errors relating to libv8 and therubyracer, view the links below for help.

* libv8: https://github.com/cowboyd/libv8/issues/205
* therubyracer: http://stackoverflow.com/questions/33475709/install-therubyracer-gem-on-osx-10-11-el-capitan, https://github.com/cowboyd/therubyracer/issues/359

#### SSL

On Windows, you may encounter an error like `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`.  If this happens, download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

### Setting up API Keys

#### Mandatory

The two primary configuration files that you need to change are `config/application.yml` and `config/smtp.yml`. They are ignored in git to prevent accidentally checking in sensitive information.

Copy the sample files to create your own configuration files:

`cp config/application.example.yml config/application.yml`

`cp config/smtp.example.yml config/smtp.yml`

`cp config/database.example.yml config/database.yml`

Run `rake secret` to generate a `SECRET_KEY_BASE` for `config/application.yml`. This is the only required configuration change.

