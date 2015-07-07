if me
=====

A community for mental health experiences

Getting Involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If would like to be added as a collaborator, email tojulianguyen@gmail.com.

Check out our Slack [page](https://ifme.slack.com) if you have any questions, ideas, or concerns!

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

On Windows, you may encounter an error like `SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed`.  If this happens, download the [CURL CA bundle](http://curl.haxx.se/ca/cacert.pem) and set the environment variable `SSL_CERT_FILE` to point to it.

### Setting Up Postgres

Time to set up a Postgres user!

```
sudo su - postgres
```

```
createuser -s -r ifme_app
````

In `pg_hba.conf`, make sure the value for `auth-method` in the `ifme_app` database is `trust`. This is because no password is being used for the local development and test databases, as seen in `database.yml`. Refer to this [guide](http://www.postgresql.org/docs/8.2/static/auth-pg-hba-conf.html) as a reference.

To find the path of `pg_hba.conf` run the following commands.

```
psql
```

```
SHOW hba_file;
```

### Running the App Locally

After exiting from Postgres by typing in `exit` in the terminal, run the following commands.

```
bin/rake db:create db:migrate
```

```
bin/rake db:setup
```

```
rails s
```

### Accessing the Database

```
rails db
```

Note that ifme_test is used when running unit tests

Testing Accounts
-----------------

They have been created in `seeds.rb`.

```
Email: test1@example.com
Password: password99
```

```
Email: test2@example.com
Password: password99
```

Unit Tests
------------

Always write unit tests for the changes you've made! If you see any missing unit tests, write them!

```
rspec
```

Committing Work
----------------

Make a fork of the repository, create a new branch for every feature you are working on!

In the spirit of open communication and community, we highly recommend that new contributors write blurb on themselves, what mental health means to them, and why they are part of if me.

This also helps people to familiarize themselves with the code base! The live contributors page can be found here: http://www.if-me.org/contributors.

Find the source code for that page and submit a pull request with your story!
