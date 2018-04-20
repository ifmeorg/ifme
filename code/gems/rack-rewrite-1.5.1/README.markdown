# rack-rewrite

A rack middleware for defining and applying rewrite rules. In many cases you
can get away with rack-rewrite instead of writing Apache mod_rewrite rules.

## Usage Examples

* [Rack::Rewrite for Site Maintenance and Downtime](http://blog.smartlogicsolutions.com/2009/11/16/rack-rewrite-for-site-maintenance-and-downtime/)
* [Rack::Rewrite + Google Analytics Makes Site Transitions Seamless](http://blog.smartlogicsolutions.com/2009/11/24/rack-rewrite-google-analytics-makes-site-transitions-seamless/)
* [Rack::Rewrite for serving gzipped pipeline assets on Heroku](https://gist.github.com/eliotsykes/6049536)

## Usage Details

### Sample rackup file

```ruby
# config.ru
gem 'rack-rewrite', '~> 1.5.0'
require 'rack/rewrite'
use Rack::Rewrite do
  rewrite   '/wiki/John_Trupiano',  '/john'
  r301      '/wiki/Yair_Flicker',   '/yair'
  r302      '/wiki/Greg_Jastrab',   '/greg'
  r301      %r{/wiki/(\w+)_\w+},    '/$1'
end
```

### Sample usage in a rails app

```ruby
# config/application.rb
config.middleware.insert_before(Rack::Lock, Rack::Rewrite) do
  rewrite   '/wiki/John_Trupiano',  '/john'
  r301      '/wiki/Yair_Flicker',   '/yair'
  r302      '/wiki/Greg_Jastrab',   '/greg'
  r301      %r{/wiki/(\w+)_\w+},    '/$1'
end
```

If you use `config.threadsafe`, you'll need to `insert_before(Rack::Runtime, Rack::Rewrite)` as `Rack::Lock` does
not exist when `config.allow_concurrency == true`:

```ruby
config.middleware.insert_before(Rack::Runtime, Rack::Rewrite) do
  rewrite   '/wiki/John_Trupiano',  '/john'
  r301      '/wiki/Yair_Flicker',   '/yair'
  r302      '/wiki/Greg_Jastrab',   '/greg'
  r301      %r{/wiki/(\w+)_\w+},    '/$1'
end
```

Or insert Rack::Rewrite to the top of the stack:

``` ruby
config.middleware.insert 0, 'Rack::Rewrite' {}
```

## Redirection codes

All redirect status codes from the [HTTP spec](http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html) are supported:

* 301 moved permanently
* 302 found
* 303 see other
* 307 temporary redirect

These translate to the following methods inside the Rack::Rewrite block:

```ruby
r301                '/wiki/John_Trupiano', '/john'
moved_permanently   '/wiki/John_Trupiano', '/john'
p                   '/wiki/John_Trupiano', '/john'    # shortcut alias

r302                '/wiki/John_Trupiano', '/john'
found               '/wiki/John_Trupiano', '/john'

r303                '/wiki/John_Trupiano', '/john'
see_other           '/wiki/John_Trupiano', '/john'

r307                '/wiki/John_Trupiano', '/john'
temporary_redirect  '/wiki/John_Trupiano', '/john'
t                   '/wiki/John_Trupiano', '/john'    # shortcut alias
```

The 303 and 307 codes were added to the HTTP spec to make unambiguously clear
what clients should do with the request method. 303 means that the new request
should always be made via GET. 307 means that the new request should use the
same method as the original request. Status code 302 was left as it is, since
it was already in use by the time these issues came to light. In practice it
behaves the same as 303.

## Use Cases

### Rebuild of existing site in a new technology

It's very common for sites built in older technologies to be rebuilt with the
latest and greatest.  Let's consider a site that has already established quite
a bit of "google juice."  When we launch the new site, we don't want to lose
that hard-earned reputation.  By writing rewrite rules that issue 301's for
old URL's, we can "transfer" that google ranking to the new site.  An example
rule might look like:

```ruby
r301 '/contact-us.php', '/contact-us'
r301 '/wiki/John_Trupiano', '/john'
```

### Retiring old routes

As a web application evolves you will undoubtedly reach a point where you need
to change the name of something (a model, e.g.).  This name change will
typically require a similar change to your routing.  The danger here is that
any URL's previously generated (in a transactional email for instance) will
have the URL hard-coded.  In order for your rails app to continue to serve
this URL, you'll need to add an extra entry to your routes file.
Alternatively, you could use rack-rewrite to redirect or pass through requests
to these routes and keep your routes.rb clean.

```ruby
rewrite %r{/features(.*)}, '/facial_features$1'
```

### CNAME alternative

In the event that you do not control your DNS, you can leverage Rack::Rewrite
to redirect to a canonical domain.  In the following rule we utilize the
$& substitution operator to capture the entire request URI.

```ruby
r301 %r{.*}, 'http://mynewdomain.com$&', :if => Proc.new {|rack_env|
  rack_env['SERVER_NAME'] != 'mynewdomain.com'
}
```

### Site Maintenance

Most capistrano users will be familiar with the following Apache rewrite rules:

```
RewriteCond %{REQUEST_URI} !\.(css|jpg|png)$
RewriteCond %{DOCUMENT_ROOT}/system/maintenance.html -f
RewriteCond %{SCRIPT_FILENAME} !maintenance.html
RewriteRule ^.*$ /system/maintenance.html [L]
```

This rewrite rule says to render a maintenance page for all non-asset requests
if the maintenance file exists.  In capistrano, you can quickly upload a
maintenance file using:

`cap deploy:web:disable REASON=upgrade UNTIL=12:30PM`

We can replace the mod_rewrite rules with the following Rack::Rewrite rule:

```ruby
maintenance_file = File.join(RAILS_ROOT, 'public', 'system', 'maintenance.html')
send_file /.*/, maintenance_file, :if => Proc.new { |rack_env|
  File.exists?(maintenance_file) && rack_env['PATH_INFO'] !~ /\.(css|jpg|png)/
}
```

If you're running Ruby 1.9, this rule is simplified:

```ruby
maintenance_file = File.join(RAILS_ROOT, 'public', 'system', 'maintenance.html')
send_file /(.*)$(?<!css|png|jpg)/, maintenance_file, :if => Proc.new { |rack_env|
  File.exists?(maintenance_file)
}
```

For those using the oniguruma gem with their ruby 1.8 installation, you can
get away with:

```ruby
maintenance_file = File.join(RAILS_ROOT, 'public', 'system', 'maintenance.html')
send_file Oniguruma::ORegexp.new("(.*)$(?<!css|png|jpg)"), maintenance_file, :if => Proc.new { |rack_env|
  File.exists?(maintenance_file)
}
```

## Rewrite Rules

### :rewrite

Calls to #rewrite will simply update the PATH_INFO, QUERY_STRING and
REQUEST_URI HTTP header values and pass the request onto the next chain in
the Rack stack.  The URL that a user's browser will show will not be changed.
See these examples:

```ruby
rewrite '/wiki/John_Trupiano', '/john'   # [1]
rewrite %r{/wiki/(\w+)_\w+}, '/$1'       # [2]
```

For [1], the user's browser will continue to display /wiki/John_Trupiano, but
the actual HTTP header values for PATH_INFO and REQUEST_URI in the request
will be changed to /john for subsequent nodes in the Rack stack.  Rails
reads these headers to determine which routes will match.

Rule [2] showcases the use of regular expressions and substitutions.  [2] is a
generalized version of [1] that will match any /wiki/FirstName_LastName URL's
and rewrite them as the first name only.  This is an actual catch-all rule we
applied when we rebuilt our website in September 2009
( http://www.smartlogicsolutions.com ).

### :r301, :r302, :r303, :r307

Calls to #r301 and #r302 have the same signature as #rewrite.  The difference,
however, is that these actually short-circuit the rack stack and send back
their respective status codes.  See these examples:

```ruby
r301 '/wiki/John_Trupiano', '/john'                # [1]
r301 %r{/wiki/(.*)}, 'http://www.google.com/?q=$1' # [2]
```

Recall that rules are interpreted from top to bottom.  So you can install
"default" rewrite rules if you like.  [2] is a sample default rule that
will redirect all other requests to the wiki to a google search.

### :send_file, :x_send_file, :send_data

Calls to #send_file and #x_send_file and #send_data also have the same signature as #rewrite.
If the rule matches, the 'to' parameter is interpreted as a path to a file
to be rendered instead of passing the application call up the rack stack.

```ruby
send_file /*/, 'public/spammers.htm', :if => Proc.new { |rack_env|
  rack_env['HTTP_REFERER'] =~ 'spammers.com'
}
x_send_file /^blog\/.*/, 'public/blog_offline.htm', :if => Proc.new { |rack_env|
  File.exists?('public/blog_offline.htm')
}
send_data /^blog\/.*/, 'public/blog_offline.png', :if => Proc.new { |rack_env|
  File.exists?('public/blog_offline.htm')
}
```

## Options Parameter

Each rewrite rule takes an optional options parameter.  The following options
are supported.

### :host

Using the :host option you can match requests to a specific hostname.

```ruby
r301 "/features", "/facial_features", :host => "facerecognizer.com"
```
This rule will only match when the hostname is "facerecognizer.com".

The :host option accepts a symbol, string, or regexp.

### :headers

Using the :headers option you can set custom response headers e.g. for HTTP
caching instructions.

```ruby
r301 "/features", "/facial_features", :headers => {'Cache-Control' => 'no-cache'}
```

Please be aware that the :headers value above is evaluated only once at app boot and shared amongst all matching requests.

Use a Proc as the :headers option if you wish to determine the additional headers at request-time. For example:

```ruby
# We want the Expires value to always be 1 year in the future from now. If
# we didn't use a Proc here, then the Expires value would be set just once
# at app startup. The Proc will be evaluated for each matching request.
send_file /^.+\.(?:ico|jpg|jpeg|png|gif|)$/,
          'public/$&',
          :headers => lambda { { 'Expires' => 1.year.from_now.httpdate } }
```

### :scheme

Using the :scheme option you can restrict the matching of a rule by the protocol of a given request.

```ruby
# Redirect all http traffic to https
r301 %r{.*}, 'https://www.example.tld$&', :scheme => 'http'
```

The :scheme option accepts a symbol, string, or regexp.

### :method

Using the :method option you can restrict the matching of a rule by the HTTP
method of a given request.

```ruby
# redirect GET's one way
r301 "/players", "/current_players", :method => :get

# and redirect POST's another way
r302 "/players", "/no_longer_available.html?message=No&longer&supported", :method => :post
```

The :method option accepts a symbol, string, or regexp.

### :if

Using the :if option you can define arbitrary rule guards.  Guards are any
object responding to #call that return true or false indicating whether the
rule matches.  The following example demonstrates how the presence of a
maintenance page on the filesystem can be utilized to take your site(s) offline.

```ruby
maintenance_file = File.join(RAILS_ROOT, 'public', 'system', 'maintenance.html')
x_send_file /.*/, maintenance_file, :if => Proc.new { |rack_env|
  File.exists?(maintenance_file)
}
```

### :not

Using the :not option you can negatively match against the path.  This can
be useful when writing a regular expression match is difficult.

```ruby
rewrite %r{^\/features}, '/facial_features', :not => '/features'
```

This will not match the relative URL /features but would match /features.xml.

## Tips

### Keeping your querystring

When rewriting a URL, you may want to keep your querystring intact (for
example if you're tracking traffic sources).  You will need to include a
capture group and substitution pattern in your rewrite rule to achieve this.

```ruby
rewrite %r{/wiki/John_Trupiano(\?.*)?}, '/john$1'
```

This rule will store the querystring in a capture group (via `(?.*)` ) and
will substitute the querystring back into the rewritten URL (via `$1`).

### Arbitrary Rewriting

All rules support passing a Proc as the first or second argument allowing you to
perform arbitrary rewrites.  The following rule will rewrite all requests
received between 12AM and 8AM to an unavailable page.

```ruby
  rewrite %r{(.*)}, lambda { |match, rack_env|
    Time.now.hour < 8 ? "/unavailable.html" : match[1]
  }
```

This rule will redirect all requests paths starting with a current date
string to /today.html

```ruby
  r301 lambda { "/#{Time.current.strftime(%m%d%Y)}.html" }, '/today.html'
```


##Alternative loaders

rack-rewrite can also be driven by external loaders. Bundled with this library is a loader for YAML files.

```
config.middleware.insert_before(Rack::Lock, Rack::Rewrite,
    :klass => Rack::Rewrite::YamlRuleSet,
    :options => {:file_name => @file_name})
```

Using syntax like

```
-
    method: r301
    from: !ruby/regexp '/(.*)/print'
    to : '$1/printer_friendly'
    options :
        host : 'example.com'
```

Any class can be used here as long as:

  - the class take an options hash
  -  `#rules` returns an array of `Rack::Rewrite::Rule` instances

## Contribute

rack-rewrite is maintained by [@travisjeffery](http://github.com/travisjeffery).

Here's the most direct way to get your work merged into the project.

- Fork the project
- Clone down your fork
- Create a feature branch
- Hack away and add tests, not necessarily in that order
- Make sure everything still passes by running tests
- If necessary, rebase your commits into logical chunks without errors
- Push the branch up to your fork
- Send a pull request for your branch

## Copyright

Copyright (c) 2012 — John Trupiano, Travis Jeffery. See LICENSE for details.
