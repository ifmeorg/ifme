[![CircleCI](https://circleci.com/gh/julianguyen/ifme/tree/master.svg?style=svg)](https://circleci.com/gh/julianguyen/ifme/tree/master)
[![Code Climate](https://codeclimate.com/github/julianguyen/ifme/badges/gpa.svg)](https://codeclimate.com/github/julianguyen/ifme)

if me
=====

if me is a community for mental health experiences that encourages people to share their personal stories with trusted allies. Trusted allies are the people we interact with on a daily basis, including friends, family members, co-workers, teachers, and mental health workers.

Dealing with mental health is what makes us human. But for a lot of us, it's a struggle to be open about it. Not everyone is a counsellor or therapist. The people who we interact with everyday shape our emotions and behavior. Getting them involved in mental health treatment is the key to recovery.

# Table of Contents

* [Goals](#goals)
* [Getting Involved](#getting-involved)
* [Installation](#installation)
* [Configuration Files](#configuration-files)
* [Running the App Locally](#running-the-app-locally)
* [Testing Accounts](#testing-accounts)
* [Testing Guidelines](#testing-guidelines)
* [Static Code Analysis](#static-code-analysis)
* [Committing Work](#committing-work)
* [Tracking Issues](#tracking-issues)
* [License](#license)

Goals
-----

* Allow users to write about their experiences (Moments) similar to a blog and get feedback and support from their allies
* Create personalized categories and moods to organize Moments and Strategies
* Develop and share Strategies to solve problems and maintain healthy self-care goals
* Keep track of medications and create alerts for them
* Create support groups whether online or offline and keep track of sessions

Check out our projects [page](https://github.com/julianguyen/ifme/projects) to see what we are currently working on!

Check our [wiki](https://github.com/julianguyen/ifme/wiki) for a summary of existing features!

Getting Involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If would like to be added as a collaborator and added to our Slack [page](https://ifme.slack.com), email join.ifme@gmail.com.

If you're looking to give feedback on the app, you can do so [here](http://goo.gl/forms/8EqoJDDiXY)!

### Contributor Code of Conduct

We use the wonderful [Contributor Covenant](http://contributor-covenant.org) for our code of conduct. Please [read it](https://github.com/julianguyen/ifme/blob/master/code_of_conduct.md) before joining our project.

Installation
-------------

The app uses  **Ruby 2.3.1** and **Rails 4.2.6**. Please stick to these versions.

### Installing Programs

The steps below should be straightforward for Linux and OS X users. Windows users please refer to this [guide](https://gist.github.com/KelseyDH/11198922) for tips on setup.

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

On OS X, if you run into nokogiri errors run `xcode-select --install`


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

##### OS X

Install via [Homebrew](http://brew.sh/)

`brew install postgresql`

then start the postgres server:

`postgres -D /usr/local/var/postgres`

For more information, follow [this postgresql guide](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/) for a more detailed setup

##### Linux

Build from the source using yum, apt-get, etc. If you already have Postgres installed, please update it.

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

Configuration Files
-------------------

### Mandatory

There are three config files: `config/env/test.env`, `config/env/development.env`, and `config/env/production.env`. To run the app locally, you should modify `test.env` and `development.env`. They are ignored in git to prevent accidentally committing sensitive information.

Copy the sample files to create your own configuration files:

`cp config/env/test.example.env config/env/test.env`

`cp config/env/development.example.env config/env/development.env`

Run `rake secret` twice to generate values for `SECRET_KEY_BASE` and `DEVISE_SECRET_KEY`.

### Email Notifications

To get email notifications working, you must configure SMTP settings in `config/env/test.env` and `config/env/development.env`.

The following [guide](https://launchschool.com/blog/handling-emails-in-rails) from Launch School is helpful.

Please do not test these with the [Testing Accounts](#testing-accounts). Create new accounts with valid email addresses!

If you want to test out scheduled emails, run the following commands: `bundle exec rake scheduler:send_take_medication_reminders`
`bundle exec rake scheduler:send_refill_reminders`
`bundle exec rake scheduler:send_perform_strategy_reminders`
`bundle exec rake scheduler:send_meeting_reminders`

#### Letter Opener

The gem `letter_opener` enables test e-mails to be sent without actually sending an e-mail accidentaly to someone through SMTP. 

You can disable this gem when you deploy the app by commenting it out.

```
# gem "letter_opener", :group => :development
```

You can read more about this gem [here](https://github.com/ryanb/letter_opener).

### Optional

The following are not mandatory, but are required if you would like to test/use these features.

[Pusher](http://pusher.com) is used in-app notifications. If you would like to use this feature in your local environment, please create your own account, generate keys, and update `PUSHER_APP_ID`, `PUSHER_KEY`, `PUSHER_SECRET` in `config/env/test.env` and `config/env/development.env`.

[Google APIs](https://console.developers.google.com) is used for OAuth (Sign in with Google) and Calendars (refill dates for Medications). If you would like to use this feature in your local environment, please create your own account, generate keys, and update `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` in `config/env/test.env` and `config/env/development.env`. You'll need activate both the Google+ API and the Contacts API for OAuth and the Calendar API for Calendars. Under the credentials tab, make sure to add the Authorized redirect URI as `http://localhost:3000/users/auth/google_oauth2/callback`. Note, you may have to hit the Save button twice for this to take effect.

[Cloudinary](https://cloudinary.com) is used to store profile pictures. If you would like to use this feature in your local environment, please create your own account, generate keys, and update `CLOUDINARY_CLOUD_NAME`, `CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET` in `config/env/test.env` and `config/env/development.env`.

Running the App Locally
-----------------------

Create the development and test databases:

```bash
bin/rake db:setup db:test:prepare
```

Start the local server:
```
rails s
```

To view the app, go to `http://localhost:3000`.

### Docker

Assuming [Docker](https://www.docker.com) is setup, you can start the server using

```
docker-compose up
```

or open a shell using

```
docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app bash
```

### Possible Errors

#### Postgres

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

Testing Guidelines
------------------

We are using Selenium for web browser automation, so you will **need** to install [Firefox](https://www.mozilla.org/en-US/firefox/new/)!

Always write tests for the changes you've made! If you see any missing tests, write them!

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

### Style Guide

* We use **2 space** indentation.
* We use **snakecase** for Ruby files and id/class names in HTML.
* We use **camelcase** for JS files.
* Make sure you run the test suite locally before you commit, don't rely on CircleCI to do that for you.
* Make sure commit messages are clear and concise are tagged with the issue number e.g. "[#99] Fixes some sample issue".
* Make sure pull requests reference the corresponding issue.
* Make sure any issues or pull requests that are UI/UX focused have appropriate screenshots.
* As a pull request (PR) reviewer, if you think the PR is good to go (including passing tests) make sure to comment with LGTM (looks good to me). You can either merge it yourself or tell the PR creator to do it themselves.
* If you add or modify a model, please run `annotate` to update the schema comments and `rake db:drop db:create db:migrate; rake db:schema:load` to update `db/schema.rb`.

### Contributor Blurb

In the spirit of open communication and community, we highly recommend that new contributors write a blurb on themselves, what mental health means to them, and why they are part of if me.

This also helps people to familiarize themselves with the code base! The live contributors page can be found [here](http://www.if-me.org/contributors). Contributor images must be at least 800x800 px and be in .jpg or .png format. Please save the image as `assets/images/contributors/firstname_lastname.png`!

If you've contributed to the project but do not want to write a blurb, please add your name and desired social media link to `app/controllers/pages_controller.rb`. Please note: The image url here appears different from the actual path you saved it at above. i.e. Write this as, image: `assets/contributors/firstname_lastname.png` within the `pages_controller.rb` file.

Tracking Issues
----------------

Please post any bugs, questions, or ideas on our [issues page](https://github.com/julianguyen/ifme/issues). If you prefer not to post publicly, you can post [here](http://goo.gl/forms/8EqoJDDiXY).

### Labelling Issues

If you create an issue, please tag it with the appropriate label. We use `enhancement` for feature work and `bug` for bugs. If you created an issue and are not working on it, please tag it as `help wanted`. The majority of technical contributors are up and coming developers, so be sure to tag appropriate issues as `newbiefriendly`! If you are working on an issue, please assign it to yourself. If you are unable to do so, please let us know and we will add you as a collaborator.

For bugs, please list the reproduction steps and specify if the bug was produced locally or on production. Please also mention what OS and browser you are using.

License
-------

The source code is licensed under GNU AGPLv3. For more information see http://www.gnu.org/licenses/agpl-3.0.txt or [LICENSE.txt](https://github.com/julianguyen/ifme/blob/master/LICENSE.txt).
