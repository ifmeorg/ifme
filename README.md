if me
=====

A community for mental health experiences

Geting Involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If would like to be added as a collaborator, email tojulianguyen@gmail.com.

Check out our Slack [page](https://ifme.slack.com) if you have any questions, ideas, or concerns!

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
