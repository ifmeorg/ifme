# Testing

## Debugging With Foreman

In one terminal tab, run `bin/start_app` which runs `bundle exec foreman start client -f Procfile.dev`.

In a second terminal tab, run `bundle exec rails s`.

This will allow you to place `debugger` in Ruby files and successfully debug.

## Testing Accounts

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

## Testing Guidelines

We are using Selenium with Chrome for web browser automation. Always write tests
for the changes you've made! If you see any missing tests, write them!

### Rspec for Ruby

Build the files beforehand:
```
cd client/
yarn build:test
```

Then at your project root directory:
```
rspec
```

### Jasmine for Rails JavaScript

Make sure PhantomJS is installed locally, either through their
[website](http://phantomjs.org) or by running `brew install phantomjs`.

#### GUI Version

In a new terminal window, run `rake jasmine`.

To view the test results, go to `http://localhost:8888`.

#### Command Line Version

```
rake jasmine:ci
```

### Jasmine for React JavaScript

```
cd client/
yarn test:watch
```
