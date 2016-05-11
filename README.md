if me
=====

A community for mental health experiences

# Table of Contents
1. [Goals](#goals)
2. [Getting Involved](#getting-involved)
3. [Getting Started](#getting-started)
4. [Setting up APIs](#setting-up-apis)
5. [Testing Accounts](#testing-accounts)
6. [Committing Work](#committing-work)
7. [License](#license)

Goals
-----

if me is a community for mental health experiences that encourages people to share their personal stories with trusted allies. Trusted allies are the people we interact with on a daily basis, including friends, family members, co-workers, teachers, and mental health workers.

Dealing with mental health is what makes us human. But for a lot of us, it's a struggle to be open about it.

Not everyone is a counsellor or therapist. The people who we interact with everyday shape our emotions and behaviour. Getting them involved in mental health treatment is the key to recovery.

The goal is to create a platform that:

* Allows users to write about their experiences (Moments) similar to a blog and get feedback and support from their allies
* Create personalized categories and moods to organize Moments and Strategies
* Develop and share Strategies to solve problems and maintain healthy goals
* Keep track of medications and create alerts for them
* Create support groups whether online or offline and keep track of sessions

Current goals:

* Improve test coverage
* Notification system
* General clean up and tweaking of UI and UX, including language throughout the app
* More helpful and visual documentation to help familiarize contributors with the project
* Usability testing

Check our [wiki](https://github.com/julianguyen/ifme/wiki) for a summary of existing features!

Getting Involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If would like to be added as a collaborator, email join.ifme@gmail.com.

Check out our Slack [page](https://ifme.slack.com) if you have any questions, ideas, or concerns!

You can provide your feedback [here](http://goo.gl/forms/8EqoJDDiXY)!

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

The app uses Rails 4.2.5 and Ruby 2.3.0

### Installing Programs

The steps below should be straightforward for Linux and OSX users. Windows users please refer to this [guide](https://gist.github.com/KelseyDH/11198922) for tips on setup.

#### Ruby on Rails
http://railsinstaller.org/en

#### Postgres

Check out http://www.postgresql.org/download/

##### OSX

Install via [Homebrew](http://brew.sh/)

`brew install postgresql`

#####Linux

Bulid from the source using yum, apt-get, etc.

##### Windows

Install via [graphical installer](http://www.postgresql.org/download/windows/)

### Install Gems

After cloning the app on your local machine, in your terminal run the following commands in the `/ifme` directory

```
bundle install
```

### Possible Errors

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

If using El Captian OS X 10.11+ and there are errors relating to libv8 and therubyracer, view the links below for help. 

libv8:

[https://github.com/cowboyd/libv8/issues/205](https://github.com/cowboyd/libv8/issues/205)

therubyracer: 
[http://stackoverflow.com/questions/33475709/install-therubyracer-gem-on-osx-10-11-el-capitan](http://stackoverflow.com/questions/33475709/install-therubyracer-gem-on-osx-10-11-el-capitan) 

On Windows, you may encounter an error like `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`.  If this happens, download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

If running bundle install on Mac OS X El Capitan v. 10.11.4 or later, please consult the following tickets for help with installing libv8 and therubyracer gems:

https://github.com/cowboyd/libv8/issues/205
https://github.com/cowboyd/therubyracer/issues/359

### Running the App Locally

Create the developement and test databases:

```bash
bin/rake db:setup db:test:prepare
```

Start the local server:
```
rails s
```

### Accessing the Database

```
rails db
```

Note that ifme_test is used when running unit tests

Setting up APIs
-----------------

Run `rake secret` to generate a `secret_key_base` for the app in `config/secrets.yml`.

[Pusher](http://pusher.com) is used in-app notifications. If you would like to use this feature in your local environment, please create your own account, generate keys, and insert them in `config/initializers/pusher.rb`.

[Google APIs](https://console.developers.google.com) is used for OAuth (Sign in with Google) and Calendars (refill dates for Medications). If you would like to use this feature in your local environment, please create your own account, generate keys, and insert them in `config/api.yml`.

[Cloudinary](https://cloudinary.com) is used to store profile pictures. If you would like to use this feature in your local environment, please create your own account, generate keys, and insert them in `config/cloudinary.yml`.

Testing Accounts
-----------------

They have been created in `seeds.rb`. Feel free to modify seeds.rb to help to your development needs! You can also test with Google accounts.

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

```
rspec
```

If you receive an error for having 'FATAL:  database "ifme_test" does not exist', run the following.
```
bin/rake db:create db:migrate RAILS_ENV=test
```

Committing Work
----------------

Make a fork of the repository, create a new branch for every feature you are working on!

In the spirit of open communication and community, we highly recommend that new contributors write blurb on themselves, what mental health means to them, and why they are part of if me.

This also helps people to familiarize themselves with the code base! The live contributors page can be found here: http://www.if-me.org/contributors.

Find the source code for that page and submit a pull request with your story!

License
-------

The source code is licensed under the Apache License. For more information see http://www.apache.org/licenses/ or LICENSE.txt.
