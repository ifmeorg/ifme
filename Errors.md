#Possible Errors You May Encounter During Installation and Configuration

If you are encountering an error that is not listed and have figured out how to resolve, please contribute to this document.

------------
Installing Ruby

Error encountered while trying to run
rvm install ruby-2.3.1

I. Error:
Requirements installation failed with status: 1.

Explanation: You run this command when Ruby is already installed in your system and you want to upgrade to 2.3.1.
Run this command to see what version you have.  
ruby -v

To fix:
Try to find other messages associated with this installation failure.

A. Also in the error message:
`Failed to update Homebrew, follow instructions here:
    https://github.com/Homebrew/homebrew/wiki/Common-Issues
and make sure `brew update` works before continuing.\n`

1. To fix this homebrew error, run
brew update

a. You may then encounter this error message,
Error: /usr/local must be writable!

To fix, run
sudo chown -R $(whoami) /usr/local
This will also prompt you for your password

b. You may also encounter this error message:
Error: update-report should not be called directly!

To fix, run
brew doctor

i. You will may encounter this warning:
Warning: Your Xcode (8.0) is outdated.
Please update to Xcode 8.2 (or delete it).
Xcode can be updated from the App Store.

To fix, run
xcode-select --install


------------

Encountering errors while trying to run
gem update --system
gem update

Error: ERROR:  While executing gem ... (Gem::RemoteFetcher::FetchError)
    SSL_connect returned=1 errno=0 state=SSLv3 read server certificate B: certificate verify failed (https://api.rubygems.org/specs.4.8.gz)

To fix:
rvm use ruby-2.3.1@rails4.2.6 --create
