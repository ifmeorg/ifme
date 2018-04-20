# chromedriver-helper

[![Build status](https://api.travis-ci.org/flavorjones/chromedriver-helper.svg)](https://travis-ci.org/flavorjones/chromedriver-helper)

Easy installation and use of [chromedriver](https://sites.google.com/a/chromium.org/chromedriver/), the Chromium project's
selenium webdriver adapter.

* [http://github.com/flavorjones/chromedriver-helper](http://github.com/flavorjones/chromedriver-helper)


# Description

`chromedriver-helper` installs an executable, `chromedriver`, in your
gem path.

This script will, if necessary, download the appropriate binary for
your platform and install it into `~/.chromedriver-helper`, then exec
it. Easy peasy!

chromedriver is fast. By my unscientific benchmark, it's around 20%
faster than webdriver + Firefox 8. You should use it!


# Usage

If you're using Bundler and Capybara, it's as easy as:

    # Gemfile
    gem "chromedriver-helper"

then, in your specs:

    Capybara.register_driver :selenium do |app|
      Capybara::Selenium::Driver.new(app, :browser => :chrome)
    end


# Specifying a version

If you want to run a specific version of chromedriver, you can set the version like so:

    Chromedriver.set_version "2.24"

Or, from the command line, you can run

    chromedriver-update 2.24


# Updating to latest Chromedriver

If you'd like to force-upgrade to the latest version of chromedriver:

1. delete the directory `$HOME/.chromedriver-helper`
2. run `chromedriver-update`

This might be necessary on platforms on which Chrome auto-updates,
which has been known to introduce incompatibilities with older
versions of chromedriver (see
[Issue #3](https://github.com/flavorjones/chromedriver-helper/issues/3)
for an example).


# Support

The code lives at
[http://github.com/flavorjones/chromedriver-helper](http://github.com/flavorjones/chromedriver-helper).
Open a Github Issue, or send a pull request! Thanks! You're the best.


## CentOS 6 and 7

Apparently recent versions of `chromedriver` won't run on CentOS 6 and 7, due to the [problems explained here](https://chrome.richardlloyd.org.uk/). The error messages look something like:

```
chromedriver: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.15' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)
chromedriver: /usr/lib64/libstdc++.so.6: version `CXXABI_1.3.5' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)
chromedriver: /usr/lib64/libstdc++.so.6: version `GLIBCXX_3.4.14' not found (required by /home/vagrant/.chromedriver-helper/linux64/chromedriver)

```

You can get `chromedriver` to work on these systems by running the `install_chrome.sh` script on the page linked to above, and then making sure your `chromedriver` process has `LD_LIBRARY_PATH` set so that `/opt/google/chrome/lib` is present, e.g.

```
$ LD_LIBRARY_PATH=/opt/google/chrome/lib chromedriver
Starting ChromeDriver 2.28.455506 (18f6627e265f442aeec9b6661a49fe819aeeea1f) on port 9515
Only local connections are allowed.

```

# License

MIT licensed, see LICENSE.txt for full details.


# Credit

The idea for this gem comes from @brianhempel's project
`chromedriver-gem` which, despite the name, is not currently published
on http://rubygems.org/.

Some improvements on the idea were taken from the installation process
for standalone Phusion Passenger.
