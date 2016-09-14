[![Build Status](https://travis-ci.org/julianguyen/ifme.svg?branch=master)](https://travis-ci.org/julianguyen/ifme)
[![Code Climate](https://codeclimate.com/github/julianguyen/ifme/badges/gpa.svg)](https://codeclimate.com/github/julianguyen/ifme)

if me
=====

if me is a community for mental health experiences that encourages people to share their personal stories with trusted allies. Trusted allies are the people we interact with on a daily basis, including friends, family members, co-workers, teachers, and mental health workers.

Dealing with mental health is what makes us human. But for a lot of us, it's a struggle to be open about it. Not everyone is a counsellor or therapist. The people who we interact with everyday shape our emotions and behavior. Getting them involved in mental health treatment is the key to recovery.

# Table of Contents
* [Goals](#goals)
* [Getting Involved](#getting-involved)
* [Getting Started](#getting-started)
* [Testing Accounts](#testing-accounts)
* [Unit Tests](#unit-tests)
* [Static Code Analysis](#static-code-analysis)
* [Committing Work](#committing-work)
* [Tracking Issues](#tracking-issues)
* [License](#license)

Goals
-----

* Allows users to write about their experiences (Moments) similar to a blog and get feedback and support from their allies
* Create personalized categories and moods to organize Moments and Strategies
* Develop and share Strategies to solve problems and maintain healthy goals
* Keep track of medications and create alerts for them
* Create support groups whether online or offline and keep track of sessions

Current goals:

* Improve test coverage
* General clean up and tweaking of UI and UX, including language throughout the app
* More helpful and visual documentation to help familiarize contributors with the project
* Usability testing

Check our [wiki](https://github.com/julianguyen/ifme/wiki) for a summary of existing features!

Getting Involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If would like to be added as a collaborator and added to our Slack [page](https://ifme.slack.com), email join.ifme@gmail.com.

If you're looking to give feedback on the app, you can do so [here](http://goo.gl/forms/8EqoJDDiXY)!

### Contributor Code of Conduct

As contributors and maintainers of this project, we pledge to respect all people who contribute through reporting issues, posting feature requests, updating documentation, submitting pull requests or patches, and other activities.

We are committed to making participation in this project a harassment-free experience for everyone, regardless of level of experience, gender, gender identity and expression, sexual orientation, disability, personal appearance, body size, race, ethnicity, age, or religion.

Examples of unacceptable behavior by participants include the use of sexual language or imagery, derogatory comments or personal attacks, trolling, public or private harassment, insults, or other unprofessional conduct.

Project maintainers have the right and responsibility to remove, edit, or reject comments, commits, code, wiki edits, issues, and other contributions that are not aligned to this Code of Conduct. Project maintainers who do not follow the Code of Conduct may be removed from the project team.

This code of conduct applies both within project spaces and in public spaces when an individual is representing the project or its community.

Instances of abusive, harassing, or otherwise unacceptable behavior may be reported by opening an issue or contacting one or more of the project maintainers.

This Code of Conduct is adapted from the [Contributor Covenant](http://contributor-covenant.org), version 1.1.0, available at [http://contributor-covenant.org/version/1/1/0/](http://contributor-covenant.org/version/1/1/0/)

Getting Started
---------------

The app uses  **Ruby 2.3.1** and **Rails 4.2.6**. Please stick to these versions.

### Installing Programs

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

#### Postgres

Check out http://www.postgresql.org/download/

##### OSX

Install via [Homebrew](http://brew.sh/)

`brew install postgresql`

After that, follow [this guide](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/) for a more detailed setup

##### Linux

Bulid from the source using yum, apt-get, etc. If you already have postgres installed, please update it.

##### Windows

Install via [graphical installer](http://www.postgresql.org/download/windows/)

### Install Gems

After cloning the app on your local machine, in your terminal run the following commands in the `/ifme` directory

```
bundle install
```

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

The two primary configuration files that you need to change are `config/application.yml` and `config/smtp.yml`. They are ignored in git to prevent accidentally committing sensitive information.

Copy the sample files to create your own configuration files:

`cp config/application.example.yml config/application.yml`

`cp config/smtp.example.yml config/smtp.yml`

`cp config/database.example.yml config/database.yml`

Run `rake secret` to generate a `SECRET_KEY_BASE` for `config/application.yml`. This is the only required configuration change.

##### Email Notifications

To get email notifications working, you must configure SMTP settings in `config/smtp.yml`.

``` ruby
development: {
  address:              '[insert address]',
    port:                 '[insert port]',
    authentication:       'plain',
    user_name:            '[insert email address]',
    password:             '[insert email password]',
    domain:               '[insert email domain]',
    enable_starttls_auto: 'true'
}

test: {
  address:              '[insert address]',
    port:                 '[insert port]',
    authentication:       'plain',
    user_name:            '[insert email address]',
    password:             '[insert email password]',
    domain:               '[insert email domain]',
    enable_starttls_auto: 'true'
}
```

The following [guide](https://launchschool.com/blog/handling-emails-in-rails) from Launch School is helpful.

Please do not test these with the [Testing Accounts](#testing-accounts). Create new accounts with valid email addresses!

#### Optional

The following are not mandatory, but are required if you would like to test/use these features.

[Pusher](http://pusher.com) is used in-app notifications. If you would like to use this feature in your local environment, please create your own account, generate keys, and update `PUSHER_APP_ID`, `PUSHER_KEY`, `PUSHER_SECRET` in `config/application.yml`.

[Google APIs](https://console.developers.google.com) is used for OAuth (Sign in with Google) and Calendars (refill dates for Medications). If you would like to use this feature in your local environment, please create your own account, generate keys, and update `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` in `config/application.yml`. You'll need activate both the Google+ API and the Contacts API for Oauth and the Calendar API for Calendars. Under the credentials tab, make sure to add the Authorized redirect URI as `http://localhost:3000/users/auth/google_oauth2/callback`. Note, you may have to hit the Save button twice for this to take effect. 

[Cloudinary](https://cloudinary.com) is used to store profile pictures. If you would like to use this feature in your local environment, please create your own account, generate keys, and update `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET` in `config/application.yml`.

### Running the App Locally

Create the developement and test databases:

```bash
bin/rake db:setup db:test:prepare
```

Start the local server:
```
rails s
```

To view the app, go to `http://localhost:3000`.

#### Possible Errors

##### Postgres

```
PG::ConnectionBad (fe_sendauth: no password supplied )
```

You may need to create a new PSQL user. Follow this [guide](https://www.digitalocean.com/community/tutorials/how-to-use-postgresql-with-your-ruby-on-rails-application-on-ubuntu-14-04) to define a username and password.
To keep this information private, list `PSQL_USERNAME` and `PSQL_PASSWORD` under `config/application.yml`, then add username and password to `config/database.yml`:

```
development: &default
  ...
  username: <%= ENV["PSQL_USERNAME"] %>
  password: <%= ENV["PSQL_PASSWORD"] %>
```

### Accessing the Database

```
rails db
```

Note that `ifme_test` is used when running unit tests

Testing Accounts
-----------------

They have been created in `db/seeds.rb`. Feel free to modify seeds.rb to help to your development needs! You can also test with Google accounts.

```
Email: test1@example.com
Password: password99
```

```
Email: test2@example.com
Password: password99
```

```
Email: test3@example.com
Password: password99
```

Unit Tests
------------

Always write unit tests for the changes you've made! If you see any missing unit tests, write them!

### Rspec for Ruby

```
rspec
```

If you receive an error for having `'FATAL:  database "ifme_test" does not exist'`, run the following.

```
bin/rake db:create db:migrate RAILS_ENV=test
```

### Jasmine for JavaScript

Make sure PhantomJS is installed locally, either through their [website](http://phantomjs.org) or by running `brew install phantomjs`.

#### GUI

In a new terminal window, run `rake jasmine`.

To view the test results, go to `http://localhost:8888`.

#### Command Line

```
rake jasmine:ci
```

Static Code Analysis
--------------------

### JSHint

```
bundle exec rake jshint
```

Committing Work
----------------

Make a fork of the repository, create a new branch for every feature you are working on! **Always make pull requests!**

If you've been added as a collaborator to the repository, please do not push unless the commit you are making is _trivial_ i.e. doesn't require a code review. If you're unsure about this, please ask!

**Everyone is encouraged to participate in code reviews, so please do so!**

### Contributor Blurb

In the spirit of open communication and community, we highly recommend that new contributors write a blurb on themselves, what mental health means to them, and why they are part of if me.

This also helps people to familiarize themselves with the code base! The live contributors page can be found [here](http://www.if-me.org/contributors). Contributor images must be at least 800x800 px and be in .jpg or .png format. Please save the image as `assets/images/contributors/firstname_lastname.png`!

If you've contributed to the project but do not want to write a blurb, please add your name and desired social media link to `app/controllers/pages_controller.rb`.


Tracking Issues
----------------

Please post any bugs, questions, or ideas on our [issues page](https://github.com/julianguyen/ifme/issues). If you prefer not to post publicly, you can post [here](http://goo.gl/forms/8EqoJDDiXY).

### Labelling Issues
If you create an issue, please tag it with the appropriate label. We use `enchancement` for feature work and `bug` for bugs. If you created an issue and are not working on it, please tag it as `help wanted`. If you are working on an issue, please assign it to yourself. If you are unable to do so, please let us know and we will add you as a collaborator.

For bugs, please list the reproduction steps and specify if the bug was prodcued locally or on production. Please also mention what OS and browser you are using.

License
-------

The source code is licensed under GNU AGPLv3. For more information see http://www.gnu.org/licenses/agpl-3.0.txt or LICENSE.txt.
