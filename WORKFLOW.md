# Workflow

# Static Code Analysis

These tools helps us to find bugs and ensure quality without having to execute code.

## JSHint for Rails JavaScript

```
bundle exec rake jshint
```

You can read about JSHint [here](http://jshint.com/docs/).

## ESLint for React JavaScript

```
cd client/
yarn eslint app
```

You can read about ESLint [here](https://eslint.org/).

## Flow for React JavaScript

```
cd client/
yarn flow
```

You can read about Flow [here](https://flow.org/en/).

### NPM Packages
Some NPM packages have flow type enabled but fail the flow checks (e.g. radium) because it relies on an older Flow version compared to the main project. You'll want to put the package path under the `[ignore]` section of `.flowconfig`, for example:

```
[ignore]
.*/node_modules/radium/.*
```

If you're wondering why we don't just ignore the entire `node_modules` folder, it's because some NPM Packages _do_ have correct type definitions, and we don't want to ignore those.

## Rubocop for Ruby

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

**Everyone is encouraged to participate in code reviews, so please do so!**

## Code Style Guide

* We use **2 space** indentation.
* We use **snakecase** for Ruby files and id/class names in HTML.
* We use **single quotes** for Ruby files.
* We use **camelcase** for JS files.
* We use **double quotes** for JS files.

* We follow airbnb's Ruby and Javascript Style Guides.
The guides are available on GitHub in the following repositories:
https://github.com/airbnb/ruby and 
https://github.com/airbnb/javascript

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
