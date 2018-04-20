## Changes in 0.22.0

### New Features

* Add support for importing hashes thru a has many association. Thanks
  to @jkowens via \#483.

### Fixes

* Fix validation logic for recursive import. Thanks to @eric-simonton-sama, @jkowens via
  \#489.

## Changes in 0.21.0

### New Features

* Allow SQL subqueries (objects that respond to .to_sql) to be passed as values. Thanks
  to @jalada, @jkowens via \#471
* Raise an ArgumentError when importing an array of hashes if any of the
  hash objects have different keys. Thanks to @mbell697 via \#465.

### Fixes

* Fix issue loading incorrect foreign key value when syncing belongs_to
  associations with custom foreign key columns. Thanks to @marcgreenstock, @jkowens via \#470.
* Fix issue importing models with polymorphic belongs_to associations.
  Thanks to @zorab47, @jkowens via \#476.
* Fix issue importing STI models with ActiveRecord 4.0. Thanks to
  @kazuki-st, @jkowens via \#478.

## Changes in 0.20.2

### Fixes

* Unscope model when synchronizing with database. Thanks to @indigoviolet via \#455.

## Changes in 0.20.1

### Fixes

* Prevent :on_duplicate_key_update args from being modified. Thanks to @joshuamcginnis, @jkowens via \#451.

## Changes in 0.20.0

### New Features

* Allow returning columns to be specified for PostgreSQL. Thanks to
  @tjwp via \#433.

### Fixes

* Fixes an issue when bypassing uniqueness validators. Thanks to @vmaxv via \#444.
* For AR < 4.2, prevent type casting for binary columns on Postgresql. Thanks to @mwalsher via \#446.
* Fix issue logging class name on import. Thanks to @sophylee, @jkowens via \#447.
* Copy belongs_to association id to foreign key column before importing. Thanks to @jkowens via \#448.
* Reset model instance on validate. Thanks to @vmaxv via \#449.

## Changes in 0.19.1

### Fixes

* Fix a regression where models weren't properly being marked clean. Thanks to @tjwp via \#434.
* Raise ActiveRecord::Import::ValueSetTooLargeError when a record being inserted exceeds the
  `max_allowed_packet` for MySQL. Thanks to @saizai, @jkowens via \#437.
* Fix issue concatenating column names array with primary key. Thanks to @keeguon via \#440.

## Changes in 0.19.0

### New Features

* For PostgreSQL, add option to set WHERE condition in conflict_action. Thanks to
  @Saidbek via \#423.

### Fixes

* Fix issue importing saved records with serialized fields. Thanks to
  @Andreis13, @jkowens via \#425.
* Fix issue importing records that have columns defined with default values
  that are functions or expressions. Thanks to @Andreis13, @jkowens via \#428.

## Changes in 0.18.3

### Fixes

* Set models new_record attribute to false when importing with
  :on_duplicate_key_ignore. Thanks to @nijikon, @jkowens via \#416.

## Changes in 0.18.2

### Fixes

* Enable custom validate callbacks when validating import. Thanks to @afn via \#410.
* Prevent wrong IDs being set on models when using :on_duplicate_key_ignore.
  Thanks to @afn, @jkowens via \#412.

## Changes in 0.18.1

### Fixes

* Fix to enable validation callbacks (before_validation,
  after_validation). Thanks to @sinsoku, @jkowens via \#406.

## Changes in 0.18.0

### New Features

* Uniqueness validation is bypassed when validating models since
  it cannot be guaranteed if there are duplicates in a batch.
  Thanks to @jkowens via \#301.
* Allow for custom timestamp columns. Thanks to @mojidabckuu, @jkowens
  via \#401.
 
### Fixes

* Fix ActiveRecord 5 issue coercing boolean values when serializing
  for the database. Thanks to @rjrobinson, @jkowens via \#403.

## Changes in 0.17.2

### Fixes

* Fix issue where PostgreSQL cannot recognize columns if names
  include mixed case characters. Thanks to @hugobgranja via \#379.
* Fix an issue for ActiveRecord 5 where serialized fields with 
  default values were not being typecast. Thanks to @whistlerbrk,
  @jkowens via \#386.
* Add option :force_single_insert for MySQL to make sure a single
  insert is attempted instead of performing multiple inserts based
  on max_allowed_packet. Thanks to @mtparet via \#387.

## Changes in 0.17.1

### Fixes

* Along with setting id on models for adapters that support it,
  add created_at and updated_at timestamps. Thanks to @jacob-carlborg
  via \#364.
* Properly set returned ids when using composite_primary_keys.
  Thanks to @guigs, @jkowens via \#371.

## Changes in 0.17.0

### New Features

* Add support for composite_primary_keys gem. Thanks to @jkowens
  via \#350.
* Add support for importing an array of hashes. Thanks to @jkowens
  via \#352.
* Add JDBC SQLite3 support. Thanks to @jkowens via \#356.

### Fixes

* Remove support for SQLite recursive imports. See \#351.
* Improve import speed for Rails 5. Thanks to @ranchodeluxe, @jkowens
  via \#359.

## Changes in 0.16.2

### Fixes

* Fixes issue clearing query cache on wrong connection when using
  multiple databases. Thanks to @KentoMoriwaki via \#337
* Raises an ArgumentError on incorrect usage of nested arrays. Thanks
  to @Nitrodist via \#340
* Fixes issue that prevented uuid primary keys from being set manually.
  Thanks to @Dclusin-og, @jkowens via \#342

## Changes in 0.16.1

### Fixes

* Fixes issue with missing error messages on failed instances when
  importing using arrays of columns and values. Thanks to @Fivell via \#332
* Update so SQLite only return ids if table has a primary key field via \#333


## Changes in 0.16.0

### New Features

* Add partial index upsert support for PostgreSQL. Thanks to @luislew via \#305
* Add UUID primary key support for PostgreSQL. Thanks to @jkowens via
  \#312
* Add store accessor support for JSON, JSON, and HSTORE data types.
  Thanks to @jkowens via \#322
* Log warning if database does not support :on_duplicate_key_update.
  Thanks to @jkowens via \#324
* Add option :on_duplicate_key_ignore for MySQL and SQLite. Thanks to
  @jkowens via \#326

### Fixes

* Fixes issue with recursive import using same primary key for all models.
  Thanks to @chopraanmol1 via \#309
* Fixes issue importing from STI subclass with polymorphic associations.
  Thanks to @JNajera via \#314
* Fixes issue setting returned IDs to wrong models when some fail validation. Also fixes issue with SQLite returning wrong IDs. Thanks to @mizukami234 via \#315


## Changes in 0.15.0

### New Features

* An ArgumentError is now raised if when no `conflict_target` or `conflict_name` is provided or can be determined when using the `on_duplicate_key_update` option for PostgreSQL. Thanks to @jkowens via \#290
* Support for Rails 5.0 final release for all except the JDBC driver which is not yet updated to support Rails 5.0

### Fixes

* activerecord-import no longer modifies a value array inside of the given values array when called with `import(columns, values)`. Thanks to @jkowens via \#291

### Misc

* `raise_error` is used to raise errors for ActiveRecord 5.0. Thanks to @couragecourag via \#294 `raise_record_invalid` has been


## Changes in 0.14.1

### Fixes

* JRuby/JDBCDriver with PostgreSQL will no longer raise a JDBCDriver error when using the :no_returning boolean option. Thanks to @jkowens via \#287

## Changes in 0.14.0

### New Features

* Support for ActiveRecord 3.1 has been dropped. Thanks to @sferik via \#254
* SQLite3 has learned the :recursive option. Thanks to @jkowens via \#281
* :on_duplicate_key_ignore will be ignored when imports are being done with :recursive. Thanks to @jkowens via \#268
* :activerecord-import learned how to tell PostgreSQL to return no data back from the import via the :no_returning boolean option. Thanks to @makaroni4 via \#276

### Fixes

* Polymorphic associations will not import the :type column. Thanks to @seanlinsley via \#282 and \#283
* ~2X speed increase for importing models with validations. Thanks to @jkowens via \#266

### Misc

* Benchmark HTML report has been fixed. Thanks to @jkowens via \#264
* seamless_database_pool has been updated to work with AR 5.0. Thanks to @jkowens via \#280
* Code cleanup, removal of redundant condition checks. Thanks to @pavlik4k via \#273
* Code cleanup, removal of deprecated `alias_method_chain`. Thanks to @codeodor via \#271


## Changes in 0.13.0

### New Features

* Addition of :batch_size option to control the number of rows to insert per INSERT statement. The default is the total number of records being inserted so there is a single INSERT statement. Thanks to @jkowens via \#245

* Addition `import!` which will raise an exception if a validation occurs. It will fail fast. Thanks to @jkowens via \#246

### Fixes

* Fixing issue with recursive import when utilizing the `:on_duplicate_key_update` option. The `on_duplicate_key_update` only applies to parent models at this time. Thanks to @yuri-karpovich for reporting and  @jkowens for fixing via \#249

### Misc

* Refactoring of fetching and assigning attributes. Thanks to @jkownes via \#259
* Lots of code cleanup and addition of Rubocop linter. Thanks to @sferik via \#256 and \#250
* Resolving errors with the test suite when running against ActiveRecord 4.0 and 4.1. Thanks to @jkowens via \#262
* Cleaning up the TravisCI settings and packages. Thanks to @sferik via \#258 and \#251

## Changes in 0.12.0

### New Features

* PostgreSQL UPSERT support has been added. Thanks @jkowens via \#218

### Fixes

* has_one and has_many associations will now be recursively imported regardless of :autosave being set. Thanks @sferik, @jkowens via \#243, \#234
* Fixing an issue with enum column support for Rails > 4.1. Thanks @aquajach via \#235

### Removals

* Support for em-synchrony has been removed since it appears the project has been abandoned. Thanks @sferik, @zdennis via \#239
* Support for the mysql gem/adapter has been removed since it has officially been abandoned. Use the mysql2 gem/adapter instead. Thanks @sferik, @zdennis via \#239

### Misc

* Cleaned up TravisCI output and removing deprecation warnings. Thanks @jkowens, @zdennis \#242


## Changes before 0.12.0

> Never look back. What's gone is now history. But in the process make memory of events to help you understand what will help you to make your dream a true story. Mistakes of the past are lessons, success of the past is inspiration. – Dr. Anil Kr Sinha
