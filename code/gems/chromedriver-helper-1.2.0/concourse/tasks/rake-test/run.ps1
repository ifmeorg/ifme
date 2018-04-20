. "c:\var\vcap\packages\windows-ruby-dev-tools\prelude.ps1"

push-location chromedriver-helper

    system-cmd "gem install bundler"
    system-cmd "bundle install"
    system-cmd "bundle exec rake spec"

pop-location
