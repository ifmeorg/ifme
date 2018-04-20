Changelog
=========

unreleased(TODO)
----------------

* with_tag should raise error when used outside have_tag
* add ability to have_form('/url', 'PUT') or have_form('/url', :PUT)
* intelligent check comments(make sure it is not searching inside comments)
* shouldn't show all markup in error message if it is too big
* order matching
* improve documentation, add more usage examples (look at changelog and code!)

0.9.1
-----

* re-added ruby support back to 1.8.7 (supporting same versions as rspec 3)
* split lib in few files

0.9.0
-----

* fixed `with_tag` nesting (thanks to [randoum](https://github.com/randoum): [#59](https://github.com/kucaahbe/rspec-html-matchers/pull/59))
* added ~> 2.4 ruby support
* removed ~> 2 ruby support

0.8.2
-----

* fixed README (thanks to [Rodrigo Castro](https://github.com/roooodcastro))
* fixed deep nesting (thanks to [Misha Gorodnitzky](https://github.com/misaka))

0.8.1
-----

* Rspec differ fix (thanks to [Misha Gorodnitzky](https://github.com/misaka))

0.8.0
-----

* "seen" text matching (thanks to [Alex Shi](https://github.com/hlcfan))

0.7.3
-----

* move license information into separate `LICENSE.md` file

0.7.2
-----

* add support for `frozen_string_literals`
* fix for rdoc links and not only

0.7.1
-----

* become compatible with RSpec pre-release versions

0.7.0
-----

* new, explicit configuration, refer to README
* added ruby 2.2.0 to CI

0.6.1
-----

* rspec 3 version update
* added ruby 2.1.2 to CI

0.6.0
-----

* introduced rspec 3.0.0 compatibility (thanks to [Tiago](https://github.com/TiagoCardoso1983))

0.5.0
-----

* new "expect" syntax support

0.4.4
-----

* options for have_tag now support Regexp (thanks to [Ian C. Anderson](http://github.com/iancanderson))

0.4.3
-----

* added license to gemspec

0.4.2
-----

* added :without to have\_tag? like have_tag('div', :without => { :class => 'test' }) NOTE: currently only classes supported

0.4.1
-----

* ruby 2.0.0 support

0.4.0
-----

* added with_text matcher
* some code refactoring, but a lot of refactoring left for future
* rewritten README, added more usage examples
* removed dealing with whitespaces (#11), too much magic for usage (#16)
* some attempt to improve documentation

0.3.5
-----

* Fix for content matching regexps with single and double quotes (#14 thanks to watsonbox)

0.3.4
-----

* capybara support

0.2.4
-----

* added simple #description method for "it { should have_tag }" cases

0.2.3
-----

* fix for unicode text matching (issue #13)

0.2.2
-----

* leading and trailing whitespaces are ignored in tags where they should be ignored(#11, and again thanks to [Simon Schoeters](http://github.com/cimm))
* whitespaces ignoring as browser does in :text matching
* have_tag backwards compability(thanks to [Felix Tjandrawibawa](https://github.com/cemeng), #12)

0.2.1
-----

* make possible use non-string as :text option(#10, thanks for idea to [Simon Schoeters](http://github.com/cimm))

0.2.0
-----

* a little bit refactoring
* added some html5 inputs
* added message for should\_not
* raise exception when wrong parametres specified(:count and :minimum (or :maximum) simultaneously)
* support all versions of nokogiri since 1.4.4

0.1.6 (nokogiri update)
-----------------------

* updated <strong>nokogiri</strong> to <strong>1.5.0</strong> version, for nokokiri less than 1.5.0 use 0.0.6 release of this gem

0.0.6
-----

* allow for single quotes in content matchers (thanks to [Kelly Felkins](http://github.com/kellyfelkins)).

0.0.5 (trial-trip)
------------------

* added some experimental matchers:
  * have\_form
    * with\_hidden\_field
    * with\_text\_field
    * with\_password\_field
    * with\_file\_field?
    * with\_text\_area
    * with\_check\_box
    * with\_radio\_button
    * with\_select
      * with\_option
    * with\_submit

0.0.4 (bugfix)
--------------

* additional parameters(:count,:text,:with) rely on each other to match what exactly tester want to match([link to comment](https://github.com/kucaahbe/rspec2-rails-views-matchers/issues#issue/2/comment/848775))

0.0.3
-----

* now following will work:

      rendered.should have_tag('div') do
        with_tag('p')
      end

* tags can be specified via symbol
* classes can be specified via array or string(class-names separated by spaces), so following will work:

      '<div class="one two">'.should have_tag('div', :with => { :class => ['two', 'one'] })
      '<div class="one two">'.should have_tag('div', :with => { :class => 'two one' })

0.0.2
------

* documented source code
* added changelog

0.0.1
------

* all needed options and error messages
