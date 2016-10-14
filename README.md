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

### Installing Postgres

Please install postgres if you don't have it already. See Postgres'
[detailed installation
guides](https://wiki.postgresql.org/wiki/Detailed_installation_guides) for help
installing Postgres on your machine.

### Clone the repo and run the setup script
To make the setup process as easy as possible, we created a setup script which
makes sure you are using the correct ruby version, installs the necessary gems
and copies over example config files. Follow the steps below to clone the repo
and run the setup script. You must have postgres and either rvm or rbenv
installed in order for the script to work.

```
git clone https://github.com/julianguyen/ifme.git
cd ifme
bin/setup
```
If the setup script is not working and you are not able to debug, see
`manual_setup.md` for instructions and solutions to possible errors. You can
also ask for help in the `#setup` channel in Slack.

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

[Google APIs](https://console.developers.google.com) is used for OAuth (Sign in with Google) and Calendars (refill dates for Medications). If you would like to use this feature in your local environment, please create your own account, generate keys, and update `GOOGLE_CLIENT_ID` and `GOOGLE_CLIENT_SECRET` in `config/application.yml`. You'll need activate both the Google+ API and the Contacts API for Oauth and the Calendar API for Calendars.

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


#### GUI

In a new terminal window, run `rake jasmine`.

To view the test results, go to `http://localhost:8888`.

#### Command Line

```
rake jasmine:ci
```

Committing Work
----------------

Make a fork of the repository, create a new branch for every feature you are working on! **Always make pull requests!**

If you've been added as a collaborator to the repository, please do not push unless the commit you are making is _trivial_ i.e. doesn't require a code review. If you're unsure about this, please ask!

**Everyone is encouraged to participate in code reviews, so please do so!**

### Contributor Blurb

In the spirit of open communication and community, we highly recommend that new contributors write a blurb on themselves, what mental health means to them, and why they are part of if me.

This also helps people to familiarize themselves with the code base! The live contributors page can be found [here](http://www.if-me.org/contributors). Contributor images must be at least 800x800 px and be in .jpg or .png format. Please save the image as `assets/contributors/firstname_lastname.png`!

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
