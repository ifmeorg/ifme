# FriendlyId Changelog

We would like to think our many {file:Contributors contributors} for
suggestions, ideas and improvements to FriendlyId.

## 5.1.0 (2015-01-15)

* FriendlyId will no longer allow blank strings as slugs ([#571](https://github.com/norman/friendly_id/pull/571)).
* FriendlyId will now try to use the first non-reserved candidate as its
  slug and will only mark the record invalid if all candidates ([#536](https://github.com/norman/friendly_id/issues/536)).
* Fix order dependence bug between history and scoped modules ([#588](https://github.com/norman/friendly_id/pull/588)).
* Fix "friendly" finds on Rails 4.2 ([#607](https://github.com/norman/friendly_id/issues/607)).

## 5.0.4 (2014-05-29)

* Bug fix for call to removed `primary` method on Edge Rails. ([#557](https://github.com/norman/friendly_id/pull/557)).
* Bug fix for unwanted slug regeneration when the slug source was changed, but not the actual generated slug ([#563](https://github.com/norman/friendly_id/pull/562)).
* Big fix to look for UUIDs only at the end of slugs ([#548](https://github.com/norman/friendly_id/pull/548)).
* Various documentation and test setup improvements.

## 5.0.3 (2013-02-14)

* Bug fix for calls to #dup with unslugged models ([#518](https://github.com/norman/friendly_id/pull/518)).
* Bug fixes for STI ([#516](https://github.com/norman/friendly_id/pull/516)).
* Bug fix for slug regeneration (both scoped and unscoped) ([#513](https://github.com/norman/friendly_id/pull/513)).
* Bug fix for finds with models that use the :history module ([#509](https://github.com/norman/friendly_id/pull/509)).

## 5.0.2 (2013-12-10)

* Query performance improvements ([#497](https://github.com/norman/friendly_id/pull/497)).
* Documentation improvements (thanks [John Bachir](https://github.com/jjb)).
* Minor refactoring of internals (thanks [Gagan Ahwad](https://github.com/gaganawhad)).
* Set slug to `nil` on call to `dup` to ensure slug is generated ([#483](https://github.com/norman/friendly_id/pull/483)).

## 5.0.1 (2013-10-27)

* Fix compatibility with Rails 4.0.1.rc3 (thanks [Herman verschooten](https://github.com/Hermanverschooten)).

## 5.0.0 (2013-10-16)

* Fix to let scoped records reuse their slugs (thanks [Donny
  Kurnia](https://github.com/donnykurnia)).

## 5.0.0.rc.3 (2013-10-04)

* Support friendly finds on associations in Rails 4.0.1 and up. They will
  currently work on Rails 4.0 associations only if `:inverse_of` is not used.
  In Rails 4-0-stable, associations have been modified to use a special
  relation class, giving FriendlyId a consistent extension point. Since the
  behavior in 4.0.0 is considered defective and fixed in 4-0-stable, FriendlyId
  5.0 will not support friendly finds on inverse relelations in 4.0.0. For a
  reliable workaround, use the `friendly` scope for friendly finds on
  associations; this works on all Rails 4.0.x versions and will continue to be
  supported.
* Documentation fixes.

## 5.0.0.rc2 (2013-09-29)

* When the :finders addon has been included, use it in FriendlyId's internal
  finds to boost performance.
* Use instance methods rather than class methods in migrations.
* On find, fall back to super when the primary key is a character type. Thanks
  to [Jamie Davidson](https://github.com/jhdavids8).
* Fix reversion to previously used slug from history table when
  `should_generate_new_friendly_id?` is overridden.
* Fix sequencing of numeric slugs

## 5.0.0.rc1 (2013-08-28)

* Removed some outdated tests.
* Improved documentation.
* Removed Guide from repository and added tasks to maintain docs up to date
  on Github pages at http://norman.github.io/friendly_id.

## 5.0.0.beta4 (2013-08-21)

* Add an initializer to the generator; move the default reserved words there.
* Allow assignment from {FriendlyId::Configuration#base}.
* Fix bug whereby records could not reuse their own slugs.

## 5.0.0.beta3 (2013-08-20)

* Update gemspec to ensure FriendlyId 5.0 is only used with AR 4.0.x.

## 5.0.0.beta2 (2013-08-16)

* Add "finders" module to easily restore FriendlyId 4.0 finder behavior.

## 5.0.0.beta1 (2013-08-10)

* Support for Rails 4.
* Made the :scoped and :history modules compatible with each other (Andre Duffeck).
* Removed class-level finders in favor of `friendly` scope (Norman Clarke).
* Implemented "candidates" support (Norman Clarke).
* Slug "sequences" are now GUIDs rather than numbers (Norman Clarke).
* `find` no longer falls back to super unless id is fully numeric string (Norman Clarke).
* Default sequence separator is now '-' rather than '--'.
* Support for Globalize has been removed until Globalize supports Rails 4.
* Removed upport for Ruby < 1.9.3 and Rails < 4.0.

## 4.0.10.1 (2013-08-20)

* Update dependencies in gemspec to avoid using with Active Record 4.
* Fixed links in docs.

## 4.0.10 (2013-08-10)

* Fixed table prefixes/suffixes being ignored (Jesse Farless).
* Fixed sequence generation for slugs containing numbers (Adam Carroll).

## 4.0.9 (2012-10-31)

* Fixed support for Rails 3.2.9.rc1

## 4.0.8 (2012-08-01)

* Name internal anonymous class to fix marshall dump/load error (Jess Brown, Philip Arndt and Norman Clarke).

* Avoid using deprecated `update_attribute` (Philip Arndt).

* Added set_friendly_id method to Globalize module (Norman Clarke).

* autoload FriendlyId::Slug; previously this class was not accessible from
  migrations unless required explicitly, which could cause some queries to
  unexpectedly fail (Norman Clarke).

* Fix Mocha load order (Mark Turner).

* Minor doc updates (Rob Yurkowski).

* Other miscellaneous refactorings and doc updates.

## 4.0.7 (2012-06-06)

* to_param just calls super when no friendly id is present, to keep the model's
  default behavior. (Andrew White)

* FriendlyId can now properly sequence slugs that end in numbers even when a
  single dash is used as the separator (Tomás Arribas).

## 4.0.6 (2012-05-21)

* Fix nil return value from to_param when save fails because of validation errors (Tomás Arribas)
* Fix incorrect usage of i18n API (Vinicius Ferriani)
* Improve error handling in reserved module (Adrián Mugnolo and Github user "nolamesa")

## 4.0.5 (2012-04-28)

* Favor `includes` over `joins` in globalize to avoid read-only results (Jakub Wojtysiak)
* Fix globalize compatibility with results from dynamic finders (Chris Salzberg)


## 4.0.4 (2012-03-26)

* Fix globalize plugin to avoid issues with asset precompilation (Philip Arndt)


## 4.0.3 (2012-03-14)

* Fix escape for '%' and '_' on SQLite (Norman Clarke and Sergey Petrunin)
* Allow FriendlyId to be extended or included (Norman Clarke)
* Allow Configuration#use to accept a Module (Norman Clarke)
* Fix bugs with History module + STI (Norman Clarke and Sergey Petrunin)

## 4.0.2 (2012-03-12)

* Improved conflict handling and performance in History module (Erik Ogan and Thomas Shafer)
* Fixed bug that impeded using underscores as a sequence separator (Erik Ogan and Thomas Shafer)
* Minor documentation improvements (Norman Clarke)

## 4.0.1 (2012-02-29)

* Added support for Globalize 3 (Enrico Pilotto and Philip Arndt)
* Allow the scoped module to use multiple scopes (Ben Caldwell)
* Fixes for conflicting slugs in history module (Erik Ogan, Thomas Shafer, Evan Arnold)
* Fix for conflicting slugs when using STI (Danny van der Heiden, Diederick Lawson)
* Maintainence improvements (Norman Clarke, Philip Arndt, Thomas Darde, Lee Hambley)

## 4.0.0 (2011-12-27)

This is a complete rewrite of FriendlyId, and introduces a smaller, faster and
less ambitious codebase. The primary change is the relegation of external slugs
to an optional addon, and the adoption of what were formerly "cached slugs"
as the primary way of handling slugging.

## Older releases

Please see the 3.x branch.
