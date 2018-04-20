rspec-html-matchers
===================

[RSpec 3](https://www.relishapp.com/rspec) matchers for testing your html (for [RSpec 2](https://www.relishapp.com/rspec/rspec-core/v/2-99/docs) use 0.5.x version).

[![Gem Version](https://badge.fury.io/rb/rspec-html-matchers.png)](http://badge.fury.io/rb/rspec-html-matchers)
[![Build Status](https://travis-ci.org/kucaahbe/rspec-html-matchers.png)](http://travis-ci.org/kucaahbe/rspec-html-matchers)

Goals
-----

* designed for testing **complex** html output. If you plan to perform simple matching, consider using:
  * [assert_select](http://api.rubyonrails.org/classes/ActionDispatch/Assertions/SelectorAssertions.html#method-i-assert_select)
  * [matchers provided out of the box in rspec-rails](https://www.relishapp.com/rspec/rspec-rails/v/2-11/docs/view-specs/view-spec)
  * [matchers provided by capybara](http://rdoc.info/github/jnicklas/capybara/Capybara/Node/Matchers)
* developer-friendly output in error messages
* built on top of [nokogiri](http://www.nokogiri.org/)
* has support for [capybara](https://github.com/jnicklas/capybara), see below
* syntax is similar to `have_tag` matcher from rspec-rails 1.x, but with own syntactic sugar
* framework agnostic, as input should be `String` (or capybara's page, see below)

Install
-------

Add to your Gemfile in the `:test` group:

```ruby
gem 'rspec-html-matchers'
```

Include it in your RSpec configuration:

```ruby
RSpec.configure do |config|
  config.include RSpecHtmlMatchers
end
```

or just in your spec(s):

```ruby
describe "my view spec" do
  include RSpecHtmlMatchers

  it "has tags" do
    expect(rendered).to have_tag('div')
  end

end
```

Cucumber configuration:

```ruby
World RSpecHtmlMatchers
```

as this gem requires **nokogiri**, here are [instructions for installing it](http://nokogiri.org/tutorials/installing_nokogiri.html).

Usage
-----

so perhaps your code produces following output:

```html
<h1>Simple Form</h1>
<form action="/users" method="post">
<p>
  <input type="email" name="user[email]" />
</p>
<p>
  <input type="submit" id="special_submit" />
</p>
</form>
```

so you test it with the following:

```ruby
expect(rendered).to have_tag('form', :with => { :action => '/users', :method => 'post' }) do
  with_tag "input", :with => { :name => "user[email]", :type => 'email' }
  with_tag "input#special_submit", :count => 1
  without_tag "h1", :text => 'unneeded tag'
  without_tag "p",  :text => /content/i
end
```

Example above should be self-descriptive, if not, please refer to the [`have_tag`](http://www.rubydoc.info/gems/rspec-html-matchers/RSpecHtmlMatchers%3Ahave_tag) documentation

Input can be any html string. Let's take a look at these examples:

* matching tags by css:

  ```ruby
  # simple examples:
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p')
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag(:p)
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p#qwerty')
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p.qwe.rty')
  # more complicated examples:
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p strong')
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p#qwerty strong')
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p.qwe.rty strong')
  # or you can use another syntax for examples above
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p') do
    with_tag('strong')
  end
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p#qwerty') do
    with_tag('strong')
  end
  expect('<p class="qwe rty" id="qwerty"><strong>Para</strong>graph</p>').to have_tag('p.qwe.rty') do
    with_tag('strong')
  end
  ```

* special case for classes matching:

  ```ruby
  # all of this are equivalent:
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :with => { :class => 'qwe rty' })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :with => { :class => 'rty qwe' })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :with => { :class => ['rty', 'qwe'] })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :with => { :class => ['qwe', 'rty'] })
  ```

  The same works with `:without`:

  ```ruby
  # all of this are equivalent:
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :without => { :class => 'qwe rty' })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :without => { :class => 'rty qwe' })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :without => { :class => ['rty', 'qwe'] })
  expect('<p class="qwe rty" id="qwerty">Paragraph</p>').to have_tag('p', :without => { :class => ['qwe', 'rty'] })
  ```

* content matching:

  ```ruby
  expect('<p> Some content&nbsphere</p>').to have_tag('p', :text => ' Some content here')
  # or
  expect('<p> Some content&nbsphere</p>').to have_tag('p') do
    with_text ' Some content here'
  end

  expect('<p> Some content&nbsphere</p>').to have_tag('p', :text => /Some content here/)
  # or
  expect('<p> Some content&nbsphere</p>').to have_tag('p') do
    with_text /Some content here/
  end

  # mymock.text == 'Some content here'
  expect('<p> Some content&nbsphere</p>').to have_tag('p', :text => mymock.text)
  # or
  expect('<p> Some content&nbsphere</p>').to have_tag('p') do
    with_text mymock.text
  end

  # matching text content as it's seen by user:
  rendered = <<HTML
  <p>
     content with ignored spaces around
  </p>
  HTML
  expect(rendered).to have_tag('p', :seen => 'content with ignored spaces around')
  ```

* usage with capybara and cucumber:

  ```ruby
  expect(page).to have_tag( ... )
  ```

where `page` is an instance of Capybara::Session

* also included shorthand matchers for form inputs:

  - have\_form
  - with\_checkbox
  - with\_email\_field
  - with\_file\_field
  - with\_hidden\_field
  - with\_option
  - with\_password\_field
  - with\_radio\_button
  - with\_button
  - with\_select
  - with\_submit
  - with\_text\_area
  - with\_text\_field
  - with\_url\_field
  - with\_number\_field
  - with\_range\_field
  - with\_date\_field

and of course you can use the `without_` matchers,
for more info take a look at [documentation](http://www.rubydoc.info/gems/rspec-html-matchers/RSpecHtmlMatchers)

### rspec 1 partial backwards compatibility:

you can match:

```ruby
expect(response).to have_tag('div', 'expected content')
expect(response).to have_tag('div', /regexp matching expected content/)
```

[RSpec 1 `have_tag` documentation](http://old.rspec.info/rails/writing/views.html)

Matching Tag Attributes
-----------------------

You can also match the content of attributes by using selectors. For example, to ensure an `img` tag has an `alt` attribute, you can match:

```ruby
expect(index).to have_tag("img[alt!='']")
```

More info
---------

You can find more on [documentation](http://www.rubydoc.info/gems/rspec-html-matchers/RSpecHtmlMatchers)

Also, please read [CHANGELOG](https://github.com/kucaahbe/rspec-html-matchers/blob/master/CHANGELOG.md) and [issues](https://github.com/kucaahbe/rspec-html-matchers/issues), might be helpful.

Contribution
============

1. Fork the repository
2. Add tests for your feature
3. Write the code
4. Add documentation for your contribution
5. Send a pull request

Contributors
============

- [Kelly Felkins](http://github.com/kellyfelkins)
- [Ryan Wilcox](http://github.com/rwilcox)
- [Simon Schoeters](https://github.com/cimm)
- [Felix Tjandrawibawa](https://github.com/cemenghttps://github.com/cemeng)
- [Szymon Przybył](https://github.com/apocalyptiq)
- [Manuel Meurer](https://github.com/manuelmeurer)
- [Andreas Riemer](https://github.com/arfl)
