# Ruby Advisory Database

The Ruby Advisory Database is a community effort to compile all security advisories that are relevant to Ruby libraries.

You can check your own Gemfile.locks against this database by using [bundler-audit](https://github.com/rubysec/bundler-audit).

## Support Ruby security!

Do you know about a vulnerability that isn't listed in this database? Open an issue, submit a PR, or [use this form](https://rubysec.com/advisories/new) which will email the maintainers.

## Directory Structure

The database is a list of directories that match the names of Ruby libraries on
[rubygems.org]. Within each directory are one or more advisory files
for the Ruby library. These advisory files are named using
the advisories' [CVE] identifier number.

    gems/:
      actionpack/:
        CVE-2014-0130.yml  CVE-2014-7818.yml  CVE-2014-7829.yml  CVE-2015-7576.yml
        CVE-2015-7581.yml  CVE-2016-0751.yml  CVE-2016-0752.yml

## Format

Each advisory file contains the advisory information in [YAML] format:

    ---
    gem: examplegem
    cve: 2013-0156
    url: https://github.com/rubysec/ruby-advisory-db/issues/123456
    title: |
      Ruby on Rails params_parser.rb Action Pack Type Casting Parameter Parsing
      Remote Code Execution

    description: |
      Ruby on Rails contains a flaw in params_parser.rb of the Action Pack.
      The issue is triggered when a type casting error occurs during the parsing
      of parameters. This may allow a remote attacker to potentially execute
      arbitrary code.

    cvss_v2: 10.0

    patched_versions:
      - ~> 2.3.15
      - ~> 3.0.19
      - ~> 3.1.10
      - ">= 3.2.11"
    unaffected_versions:
      - ~> 2.4.3

    related:
      cve:
        - 2013-1234567
        - 2013-1234568
      url:
        - https://github.com/rubysec/ruby-advisory-db/issues/123457


### Schema

* `gem` \[String\]: Name of the affected gem.
* `framework` \[String\] (optional): Name of framework gem belongs to.
* `platform` \[String\] (optional): If this vulnerability is platform-specific, name of platform this vulnerability affects (e.g. JRuby)
* `cve` \[String\]: CVE id.
* `osvdb` \[Integer\]: OSVDB id.
* `url` \[String\]: The URL to the full advisory.
* `title` \[String\]: The title of the advisory.
* `date` \[Date\]: Disclosure date of the advisory.
* `description` \[String\]: Multi-paragraph description of the vulnerability.
* `cvss_v2` \[Float\]: The [CVSSv2] score for the vulnerability.
* `cvss_v3` \[Float\]: The [CVSSv3] score for the vulnerability.
* `unaffected_versions` \[Array\<String\>\] (optional): The version requirements for the
  unaffected versions of the Ruby library.
* `patched_versions` \[Array\<String\>\]: The version requirements for the
  patched versions of the Ruby library.
* `related` \[Hash\<Array\<String\>\>\]: Sometimes an advisory references many urls and cves. Supported keys: `cve` and `url`

### Tests
Prior to submitting a pull request, run the tests:

```
bundle install
bundle exec rspec
```

## Credits

Please see [CONTRIBUTORS.md].

This database also includes data from the [Open Source Vulnerability Database][OSVDB]
developed by the Open Security Foundation (OSF) and its contributors.

[rubygems.org]: https://rubygems.org/
[CVE]: http://cve.mitre.org/
[OSVDB]: http://www.osvdb.org/
[CVSSv2]: https://www.first.org/cvss/v2/guide
[CVSSv3]: https://www.first.org/cvss/user-guide
[YAML]: http://www.yaml.org/
[CONTRIBUTORS.md]: https://github.com/rubysec/ruby-advisory-db/blob/master/CONTRIBUTORS.md
