# Contributing Guidelines

* All text must be within 80 columns.
* YAML must be indented by 2 spaces.
* Have any questions? Feel free to open an issue.
* Prior to submitting a pull request, run the tests:

```
bundle install
bundle exec rspec
```

* Follow the schema. Here is an example advisory:

```yaml
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

```
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


[CVSSv2]: https://www.first.org/cvss/v2/guide
[CVSSv3]: https://www.first.org/cvss/user-guide
