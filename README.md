[![CircleCI](https://circleci.com/gh/julianguyen/ifme/tree/master.svg?style=svg)](https://circleci.com/gh/julianguyen/ifme/tree/master)
[![Code Climate](https://codeclimate.com/github/julianguyen/ifme/badges/gpa.svg)](https://codeclimate.com/github/julianguyen/ifme)
[![Backers on Open Collective](https://opencollective.com/ifme/backers/badge.svg)](#backers)
[![Sponsors on Open Collective](https://opencollective.com/ifme/sponsors/badge.svg)](#sponsors)

# if me

if me is a community for mental health experiences that encourages people to
share their personal stories with trusted allies. Trusted allies are the people
we interact with on a daily basis, including friends, family members,
co-workers, teachers, and mental health workers.

Dealing with mental health is what makes us human. But for a lot of us, it's a
struggle to be open about it. Not everyone is a counsellor or therapist. The
people who we interact with everyday shape our emotions and behavior. Getting
them involved in mental health treatment is the key to recovery.

**Read about our project goals and how to contribute (not just as a developer) [here](https://github.com/julianguyen/ifme/blob/master/CONTRIBUTING.md).**

We use the wonderful [Contributor Covenant](http://contributor-covenant.org) for
our code of conduct. Please
[read it](https://github.com/julianguyen/ifme/blob/master/code_of_conduct.md)
before joining our project.

# Table of Contents

* [Installation](#installation)
* [Configuration Files](#configuration-files)
* [Running the App Locally](#running-the-app-locally)
* [Testing Accounts](#testing-accounts)
* [Testing Guidelines](#testing-guidelines)
* [Static Code Analysis](#static-code-analysis)
* [Committing Work](#committing-work)
* [Tracking Issues](#tracking-issues)
* [Donate](#donate)
* [License](#license)

# Installation

The app uses  **Ruby 2.3.4** and **Rails 5.0.5**. Please stick to these versions.

The steps below should be straightforward for Linux and macOS users. Windows
users please refer to this [guide](https://gist.github.com/KelseyDH/11198922)
for tips on setup.

Commons errors faced during installation are documented in this
[guide](https://github.com/julianguyen/ifme/blob/master/COMMON_ERRORS.md).

<details>
  <summary>1) Install Ruby on Rails (click to expand)</summary>

## Ruby on Rails

If you do not have Rails, use this handy [guide](http://installrails.com).

If you're updating an existing installation through RVM or rbenv, continue to
(A) or (B).

#### Option (A) RVM

Assuming you have [RVM](https://rvm.io/rvm/install) installed, update to the
latest version

```
rvm get stable --autolibs=enable
```

**Close and re-open the terminal window**

```
rvm install ruby-2.3.4
```

Check that Ruby has been updated by running `ruby -v`.

#### Option (B) rbenv

Follow instructions for updating rbenv at the project's [GitHub](https://github.com/rbenv/rbenv).
Make sure you also upgrade `ruby-build` if you used Homebrew to install rbenv.

Run the following to install Ruby 2.3.4:

```
rbenv install 2.3.4
```

Once you have cloned the project, set the local Ruby version to 2.3.4:

```
cd ifme
rbenv local 2.3.4
```

## Gems: After updating or installing Ruby

Update the gem manager by running `gem update --system`.

Update your gems by running `gem update`.

If you are missing `bundler`, please install it

```
gem install bundler
```

Make a gemset for the specific Ruby on Rails version through RVM or rbenv.
Continue to (A) or (B).

#### Option (A) RVM

```
rvm use ruby-2.3.4@rails5.0.5 --create
```

#### Option (B) rbenv

 [rbenv-gemset](https://github.com/jf/rbenv-gemset)

### Updating An Existing Rails Installation

```
gem install rails --version=5.0.5
```

Restart your terminal (or open a new tab)

Check that Rails has been updated by running `rails -v`.
</details>

<details>
  <summary>2) Install Postgres (click to expand)</summary>

## Postgres

After installing Postgres, if you are asked to create a new user, please follow
these [instructions](https://github.com/julianguyen/ifme/blob/master/COMMON_ERRORS.md#postgresql-bad-connection).

#### A. macOS

Install via [Homebrew](http://brew.sh/)

`brew install postgresql`

then start the postgres server:

`postgres -D /usr/local/var/postgres`

For more information, follow
[this postgresql guide](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/)
for a more detailed setup

#### B. Linux

Build from the source using yum, apt-get, etc. If you already have Postgres
installed, please update it.

#### C. Windows

Install via [graphical installer](http://www.postgresql.org/download/windows/)

## Install Gems

After cloning the app on your local machine, in your terminal run the following
command in the `/ifme` directory

```
bundle install
```
</details>

# Configuration Files

<details>
  <summary>Mandatory (click to expand)</summary>

## Mandatory

There are two config files: `config/env/test.env` and
`config/env/development.env`. To run the app locally, you should modify
`test.env` and `development.env`. They are ignored in git to prevent
accidentally committing sensitive information.

### Automatic setup

For your development and test environments, you can automatically generate the
env files by running `bin/rake setup_workspace`.

## Manual setup

Copy the sample files to create your own configuration files:

`cp config/env/test.example.env config/env/test.env`
`cp config/env/development.example.env config/env/development.env`

Run `rake secret` twice to generate values for `SECRET_KEY_BASE` and
`DEVISE_SECRET_KEY`. The values in `test.env` and `development.env` can be the
same.

BE CAREFUL: The secret should be in the test.env and development.env NOT the
config/env/test.example.env or config/env/development.example.env files.
The example files are not ignored by git.
</details>

<details>
  <summary>Optional (click to expand)</summary>

## Optional
The following are not mandatory, but are required if you would like to test/use
these features.

### Pusher

[Pusher](http://pusher.com) is used in-app notifications. If you would like to
use this feature in your local environment, please create your own account,
generate keys, and update `PUSHER_APP_ID`, `PUSHER_KEY`, `PUSHER_SECRET` in
`config/env/test.env` and `config/env/development.env`.

### Google OAuth 2.0 IDs

[Google OAuth 2.0 IDs](https://console.developers.google.com) is used for
OAuth (Sign in with Google) and Calendars (refill dates for Medications).
If you would like to use this feature in your local environment, please create
your own account, generate keys, and update `GOOGLE_CLIENT_ID` and
`GOOGLE_CLIENT_SECRET` in `config/env/test.env` and `config/env/development.env`.
You'll need to activate both the Google+ API and the Contacts API for OAuth, and
the Calendar API for Calendars. Under the credentials tab, make sure to add the
Authorized redirect URI as `http://localhost:3000/users/auth/google_oauth2/callback`.
Note, you may have to hit the Save button twice for this to take effect.

We have a [wiki](https://github.com/julianguyen/ifme/wiki/Setup-Google-Auth-for-Testing)
with step by step instructions if you get lost in the process.

### Google API

[Google API](https://console.developers.google.com) is used for location
autocomplete, specifically the Maps JavaScript API (which needs to be activated).
If you would like to use this feature in your local environment, please create]
your own account, generate keys, and update `GOOGLE_API_KEY` in
`config/env/test.env` and `config/env/development.env`.

We have a [wiki](https://github.com/julianguyen/ifme/wiki/Setup-Google-Auth-for-Testing)
with step by step instructions if you get lost in the process.

### Cloudinary

[Cloudinary](https://cloudinary.com) is used to store profile pictures. If you
would like to use this feature in your local environment, please create your own
]account, generate keys, and update `CLOUDINARY_CLOUD_NAME`,
`CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET` in `config/env/test.env` and
`config/env/development.env`.

If want to generate
[static images](http://cloudinary.com/blog/how_to_deliver_your_static_images_through_a_cdn_in_ruby_on_rails)
through the Cloudinary CDN, run `heroku run rake cloudinary:sync_static`.

### Email Notifications

To get email notifications working, you must configure SMTP settings in
`config/env/test.env` and `config/env/development.env`.

The following [guide](https://launchschool.com/blog/handling-emails-in-rails)
from Launch School is helpful.

Please do not test these with the [Testing Accounts](#testing-accounts). Create
new accounts with valid email addresses!

If you want to test out scheduled emails, run the following commands:

`bundle exec rake scheduler:send_take_medication_reminders`

`bundle exec rake scheduler:send_refill_reminders`

`bundle exec rake scheduler:send_perform_strategy_reminders`

`bundle exec rake scheduler:send_meeting_reminders`

### Letter Opener

The gem `letter_opener` enables test e-mails to be sent without actually sending
an e-mail accidentally to someone through SMTP.

You can disable this gem when you deploy the app by commenting it out.

```
# gem "letter_opener", :group => :development
```

You can read more about this gem [here](https://github.com/ryanb/letter_opener).
</details>

# Running the App Locally

Create the development and test databases:

```bash
bin/rake db:setup db:test:prepare
```

Run `rake slugs:slugify` to update existing entries in the database with slugs
(e.g. `moments/fun-slug`)

Start the local server:
```
rails s
```

To view the app, go to `http://localhost:3000`.

To view the app on your mobile device, go to `http://[YOUR IP ADDRESS]:3000`.

<details>
  <summary>Docker (click to expand)</summary>

### Docker

Assuming [Docker](https://www.docker.com) is setup, you can start the server
using

```
docker-compose up
```

or open a shell using

```
docker-compose -f docker-compose.yml -f docker-compose.test.yml run --rm app
bash
```
</details>

<details>
  <summary>Vagrant (click to expand)</summary>

### Vagrant

Assuming [Vagrant](https://www.vagrantup.com/docs/installation/) is setup, you
can add the following line to your Vagrantfile. Make sure to add it exactly as
below - with `:` and not quotes, or it may not work properly.


```
config.vm.network :forwarded_port, guest: 3000, host: 3000
```

Rails binds to 127.0.0.1, so you may need to specify 0.0.0.0 when starting the
server for localhost.

```
bin/rails server -b 0.0.0.0
```
</details>

## Accessing the Database

```
rails db
```

Note that `ifme_test` is used when running unit tests

# Testing Accounts

They have been created in `db/seeds.rb`. Feel free to modify seeds.rb to help to
your development needs! You can also test with Google accounts.

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

# Testing Guidelines

We are using Selenium with Chrome for web browser automation. Always write tests
for the changes you've made! If you see any missing tests, write them!

## Rspec for Ruby

```
rspec
```

## Jasmine for JavaScript

Make sure PhantomJS is installed locally, either through their
[website](http://phantomjs.org) or by running `brew install phantomjs`.

### GUI Version

In a new terminal window, run `rake jasmine`.

To view the test results, go to `http://localhost:8888`.

### Command Line Version

```
rake jasmine:ci
```

# Static Code Analysis

These tools helps us to find bugs and ensure quality without having to execute code.

## JSHint

```
bundle exec rake jshint
```

You can read about JSHint [here](http://jshint.com/docs/).

## Rubocop

```
rubocop
```

You can read about Rubocop [here](http://rubocop.readthedocs.io/en/latest/).

# Committing Work

Make a fork of the repository, create a new branch for every feature you are
working on! **Always make pull requests!**

If you've been added as a collaborator to the repository, please do not push
unless the commit you are making is _trivial_ i.e. doesn't require a code
review. If you're unsure about this, please ask!

**Everyone is encouraged to participate in code reviews, so please do so!**

## Style Guide

* We use **2 space** indentation.
* We use **snakecase** for Ruby files and id/class names in HTML.
* We use **single quotes** for Ruby files.
* We use **camelcase** for JS files.
* We use **double quotes** for JS files.
* Please run [Static Code Analysis](#static-code-analysis) locally before you make a pull request, don't rely on Codeclimate to do that for you.
* Make sure you run the test suite locally before you make a pull request, don't rely on
CircleCI to do that for you.
* Make sure commit messages are clear and concise are tagged with the issue
number e.g. "[#99] Fixes some sample issue".
* Make sure pull requests reference the corresponding issue.
* Make sure any issues or pull requests that are UI/UX focused have appropriate screenshots.
* As a pull request (PR) reviewer, if you think the PR is good to go
(including passing tests) make sure to comment with LGTM (looks good to me).
You can either merge it yourself or tell the PR creator to do it themselves.
* If you add or modify a model, please run `annotate` to update the schema
comments and `rake db:drop db:create db:migrate; rake db:schema:load` to update `db/schema.rb`.

## Contributor Blurb

In the spirit of open communication and community, we highly recommend that new
contributors write a blurb on themselves, what mental health means to them, and
why they are part of the project.

This also helps people to familiarize themselves with the code base! The live
contributors page can be found [here](http://www.if-me.org/contributors).
Contributor images must be at least 800x800 px and be in .jpg or .png format.
Please save the image as
`app/assets/images/contributors/firstname_lastname.png`! Add your blurb to
`doc/pages/blurbs.json`.

If you've contributed to the project but do not want to write a blurb, please
add your name and desired social media link to `doc/pages/contributors.json`.

Below are folks who have contributed via GitHub!

<a href="graphs/contributors"><img src="https://opencollective.com/ifme/contributors.svg?width=890" /></a>

# Tracking Issues

Please post any bugs, questions, or ideas on our
[issues page](https://github.com/julianguyen/ifme/issues). If you prefer not to
post publicly, you can post [here](http://goo.gl/forms/8EqoJDDiXY).

## Labelling Issues

If you create an issue, please tag it with the appropriate label. We use
`enhancement` for feature work and `bug` for bugs. If you created an issue and
are not working on it, please tag it as `help wanted`. The majority of technical
contributors are up and coming developers, so be sure to tag appropriate issues
as `newbiefriendly`! If you are working on an issue, please assign it to
yourself. If you are unable to do so, please let us know and we will add you as
a collaborator.

For bugs, please list the reproduction steps and specify if the bug was produced
locally or on production. Please also mention what OS and browser you are using.

## Donate

We also welcome financial contributions in full transparency on our
[Open Collective](https://opencollective.com/ifme).
Anyone can file an expense. If the expense makes sense for the development of
the community, it will be "merged" in the ledger of our Open Collective by the
core contributors and the person who filed the expense will be reimbursed.

We also have a [Patreon](https://www.patreon.com/ifme) page where you can give
monthly donations.

### Backers

Thank you to our Patreon backers [Rob Drimmie](https://www.patreon.com/user?u=3251857),
[Joseph D. Marhee](https://www.patreon.com/user?u=2899171), and
[Carol Willing](https://www.patreon.com/user?u=202458)!

Thank you to all our Open Collective backers!
[Become a backer!](https://opencollective.com/ifme#backer)

<a href="https://opencollective.com/ifme#backers" target="_blank"><img src="https://opencollective.com/ifme/backers.svg?width=890"></a>

### Sponsors

Thank you to all our sponsors! (please ask your company to also support this
open source project by [becoming a sponsor](https://opencollective.com/ifme#sponsor))

<a href="https://opencollective.com/ifme/sponsor/0/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/0/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/1/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/1/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/2/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/2/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/3/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/3/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/4/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/4/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/5/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/5/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/6/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/6/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/7/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/7/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/8/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/8/avatar.svg"></a>
<a href="https://opencollective.com/ifme/sponsor/9/website" target="_blank"><img src="https://opencollective.com/ifme/sponsor/9/avatar.svg"></a>

# License

The source code is licensed under GNU AGPLv3. For more information see
http://www.gnu.org/licenses/agpl-3.0.txt or
[LICENSE.txt](https://github.com/julianguyen/ifme/blob/master/LICENSE.txt).
