# Tips for Contributors

## Summary

For non-doc fixes:

* Provide changelog entry in the [unreleased section of the CHANGELOG.md](https://github.com/shakacode/react_on_rails/blob/master/CHANGELOG.md#unreleased).
* Ensure CI passes and that you added a test that passes with the fix and fails without the fix.
* Optionally, squash all commits down to one with a nice commit message *ONLY* once final review is given. Make sure this single commit is rebased on top of master.
* Please address all code review comments.
* Ensure that docs are updated accordingly if a feature is added.

## Commit Messages

From [How to Write a Git Commit Message](http://chris.beams.io/posts/git-commit/)

#### The seven rules of a great git commit message
> Keep in mind: This has all been said before.

1. Separate subject from body with a blank line
1. Limit the subject line to 50 characters
1. Capitalize the subject line
1. Do not end the subject line with a period
1. Use the imperative mood in the subject line
1. Wrap the body at 72 characters
1. Use the body to explain what and why vs. how


## To run:
 
### Tests
```
rake test
```

### Linting

```
rake rubocop
```

or to autofix: 

```
bundle exec rubocop -a
```

### Debugging

Enable pry by setting an ENV value for `USE_PRY`. When you use pry, you may get a useless warning about circular references.

### All ci

```sh
rake
```

# Configuring to test changes with your app

Use the relative path syntax in your gemfile.

```ruby
gem "webpacker_lite", path: "../../../webpacker_lite"
```

# Advice for Project Maintainers and Contributors

What do project maintainers do? What sort of work is involved? [sstephenson](https://github.com/sstephenson) wrote in the [turbolinks](https://github.com/turbolinks/turbolinks) repo:

> [Why this is not still fully merged?](https://github.com/turbolinks/turbolinks/pull/124#issuecomment-239826060)

# Releasing

Using [gem-release](https://github.com/svenfuchs/gem-release).

If the version to bump is `2.0.3`

```
git checkout master
git pull --rebase
gem bump --version 2.0.3
bundle
git commit -am "Update Gemfile.lock"
gem release --tag
```
