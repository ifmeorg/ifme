# Installation

The app uses  **Ruby 2.3.4** and **Rails 5.0.5**. Please stick to these versions.

The steps below should be straightforward for Linux and macOS users. Windows
users please refer to this [guide](https://gist.github.com/KelseyDH/11198922)
for tips on setup.

Commons errors faced during installation are documented in this
[guide](https://github.com/julianguyen/ifme/wiki/Common-Dev-Environment-Errors).

<details>
  <summary>1) Install Postgres (click to expand)</summary>

## Postgres

After installing Postgres, if you are asked to create a new user, please follow
these [instructions](https://github.com/julianguyen/ifme/blob/master/documentation/COMMON_ERRORS.md#postgresql-bad-connection).

### A. macOS

Install via [Homebrew](http://brew.sh/)

`brew install postgresql`

then start the postgres server:

`postgres -D /usr/local/var/postgres`

For more information, follow
[this postgresql guide](http://exponential.io/blog/2015/02/21/install-postgresql-on-mac-os-x-via-brew/)
for a more detailed setup

### B. Linux

Install using your package management software (e.g. apt, yum, etc.).

It may also be necessary to install a separate development files package or the
Ruby gem may not compile. On Ubuntu/Debian, this package is called
postgresql-server-dev-X.Y (e.g. postgresql-server-dev-9.4). If you are unsure of
what the package is for your distribution, continue following the instructions;
usually bundler will let you know what you need to install.

Most likely, PostgreSQL will be running under a new user called "postgresql" and
your user will not have permission to connect to the database. You can add
yourself as a user by running:

```
sudo -u postgres createuser -s $(whoami)
createdb $(whoami)
```

### C. Windows

Install via [graphical installer](http://www.postgresql.org/download/windows/)

## Install Gems

After cloning the app on your local machine, in your terminal run the following
command in the `/ifme` directory

```
bundle install
```
</details>

<details>
  <summary>2) Install Ruby on Rails (click to expand)</summary>

## Ruby on Rails

If you do not have Rails, use this handy [guide](http://installrails.com).

If you're updating an existing installation through RVM or rbenv, continue to
(A) or (B).

### Option (A) RVM

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

### Option (B) rbenv

Follow instructions for updating rbenv at the project's [GitHub](https://github.com/rbenv/rbenv).
Make sure you also upgrade `ruby-build` if you used Homebrew to install rbenv.

Run the following to install Ruby 2.3.4:

```
rbenv install 2.3.4
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

### Option (A) RVM

```
rvm use ruby-2.3.4@rails5.0.5 --create
```

### Option (B) rbenv

 [rbenv-gemset](https://github.com/jf/rbenv-gemset)
</details>

<details>
  <summary>3) Install Yarn (click to expand)</summary>

## Install Yarn

There are step-by-steps [here](https://yarnpkg.com/en/docs/install) for all of the major operating systems.

```
cd client/
yarn install
```

</details>

## Configuration Files

<details>
  <summary>Mandatory (click to expand)</summary>

### Mandatory

There are two config files: `config/env/test.env` and
`config/env/development.env`. To run the app locally, you should modify
`test.env` and `development.env`. They are ignored in git to prevent
accidentally committing sensitive information.

#### Automatic setup

For your development and test environments, you can automatically generate the
env files by running `bin/rake setup_workspace`.

#### Manual setup

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

### Optional
The following are not mandatory, but are required if you would like to test/use
these features.

#### Pusher

[Pusher](http://pusher.com) is used in-app notifications. If you would like to
use this feature in your local environment, please create your own account,
generate keys, and update `PUSHER_APP_ID`, `PUSHER_KEY`, `PUSHER_SECRET` in
`config/env/test.env` and `config/env/development.env`.

#### Google OAuth 2.0 IDs

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

#### Google API

[Google API](https://console.developers.google.com) is used for location
autocomplete, specifically the Maps JavaScript API (which needs to be activated).
If you would like to use this feature in your local environment, please create]
your own account, generate keys, and update `GOOGLE_API_KEY` in
`config/env/test.env` and `config/env/development.env`.

We have a [wiki](https://github.com/julianguyen/ifme/wiki/Setup-Google-Auth-for-Testing)
with step by step instructions if you get lost in the process.

#### Cloudinary

[Cloudinary](https://cloudinary.com) is used to store profile pictures. If you
would like to use this feature in your local environment, please create your own
]account, generate keys, and update `CLOUDINARY_CLOUD_NAME`,
`CLOUDINARY_API_KEY`, and `CLOUDINARY_API_SECRET` in `config/env/test.env` and
`config/env/development.env`.

If want to generate
[static images](http://cloudinary.com/blog/how_to_deliver_your_static_images_through_a_cdn_in_ruby_on_rails)
through the Cloudinary CDN, run `heroku run rake cloudinary:sync_static`.

#### Email Notifications

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

#### Letter Opener

The gem `letter_opener` enables test e-mails to be sent without actually sending
an e-mail accidentally to someone through SMTP.

You can disable this gem when you deploy the app by commenting it out.

```
# gem "letter_opener", :group => :development
```

You can read more about this gem [here](https://github.com/ryanb/letter_opener).

#### Secret Share

Secret Share is a feature to share a moment, with a secret URL for a certain amount of time.

You can enable this feature by adding `config.secret_share_enabled = true` to the development.rb file.

</details>

## Running the App Locally

Create the development and test databases:

```bash
bin/rake db:setup db:test:prepare
```

Run `rake slugs:slugify` to update existing entries in the database with slugs
(e.g. `moments/fun-slug`)

Start the local server:
```
bin/start_app
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

Note that `ifme_test` is used when running unit tests.
