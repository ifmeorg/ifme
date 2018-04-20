chromedriver-helper changelog
==========

1.2.0 - 2018-02-03
----------

Dependencies:

* Bump dependencies on `nokogiri` and `archive-zip. (Thanks, @odlp and @ksylvest!)


Bug fixes:

* Use `https` for the URL used to download. [#41] (Thanks, @saraid!)
* Better platform detection, no longer run Windows on unrecognized platforms. [#49] (Thanks, @duncan-bayne!)
* `chromedriver-update` without a version specified will update to the latest version available on the internets. [#47]



1.1.0 - 2017-03-19
----------

Features:

* Allow user to choose what version of chromedriver runs. [#34] (Thanks, @jonny5!)


1.0.0 - 2015-06-06
----------

* Updated gemspec info. Happy 1.0!


0.0.9 - 2015-06-06
----------

* No longer require 'curl' or 'wget', or 'unzip' utilities to be installed. You know, for Windows. (Thanks, @elementc!)
* Support JRuby by removing dependency on native-C-extension gem. (Thanks, Marques Lee!)


0.0.8 - 2015-01-23
----------

* Guaranteeing that we get the *latest* version of chromedriver. (#15) (Thanks, @AlexRiedler!)


0.0.7 - 26 Aug 2014
----------

* Added support for windows binaries. (Thanks, @elementc!)


0.0.6 - 26 Aug 2014
----------

* Fixed to work with new Google download page. #7 (Thanks, @mars!)


0.0.5 - 15 Aug 2012
----------

* Fixed support for JRuby on non-Windows platforms. #4 (Thanks, Tim Olsen!)


0.0.4 - 1 Aug 2012
----------

* Including `chromedriver-update` to easily allow people to force-upgrade. #3


0.0.3 - 20 Mar 2012
----------

* Updated download URL. #2 (Thanks, Alistair Hutchison!)


0.0.2 - 6 December 2011
----------

* Birthday!
