if me
=====

An open-source community for mental health experiences

Geting involved
---------------

Fork the repository, pick up an issue, or create an issue for a feature you would like to see. If you have any questions, email tojulianguyen@gmail.com.

Getting started
---------------

Easiest ways to install Ruby on Rails and Postgres:

http://railsinstaller.org/en

http://www.postgresql.org/download/

The steps below should be straightforward for Linux and OSX users. Windows users please refer to this [guide](https://gist.github.com/KelseyDH/11198922) for troubleshooting tips on setup.

After cloning the app on your local machine, in your terminal run the following commands to get it up and running:

```
bundle install
```

If "Ruby Bundle Symbol not found: _SSLv2_client_method (LoadError)" is encountered, try running:

```
rvm get stable
```

```
rvm reinstall ruby
```

```
rvm gemset pristine
```

On Windows, you may encounter an error like "SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed".  If this happens, download the CURL CA bundle from http://curl.haxx.se/ca/cacert.pem and set the environment variable SSL_CERT_FILE to point to it.

Time to set up a Postgres user:

```
sudo su - postgres
```

```
createuser -s -r [username here]
````

After exiting from Postgres:

```
bin/rake db:create db:migrate
```

```
rails s
```

Testing accounts
-----------------

They have been created in seeds.rb

```
Email: test1@example.com
Password: password99
```

```
Email: test2@example.com
Password: password99
```

Rspec tests
------------

Always write unit tests for the changes you've made! If you see any missing unit tests, write them!

```
rspec
```
