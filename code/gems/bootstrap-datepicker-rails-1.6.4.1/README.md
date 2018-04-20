# Bootstrap Datepicker for Rails

[![Gem Version](https://badge.fury.io/rb/bootstrap-datepicker-rails.png)](http://badge.fury.io/rb/bootstrap-datepicker-rails)

[![endorse](https://api.coderwall.com/nerian/endorsecount.png)](https://coderwall.com/nerian)

bootstrap-datepicker-rails project integrates a datepicker with Rails 3 assets pipeline.

http://github.com/Nerian/bootstrap-datepicker-rails

https://github.com/eternicode/bootstrap-datepicker

## Rails > 3.1
Include bootstrap-datepicker-rails in Gemfile;

``` ruby
gem 'bootstrap-datepicker-rails'
```

or you can install from latest build;

``` ruby
gem 'bootstrap-datepicker-rails', :require => 'bootstrap-datepicker-rails',
                              :git => 'git://github.com/Nerian/bootstrap-datepicker-rails.git'
```

and run bundle install.

## Configuration

Add this line to app/assets/stylesheets/application.css

``` css
 *= require bootstrap-datepicker
 # Or if using bootstrap v3:
 *= require bootstrap-datepicker3
```

Add this line to app/assets/javascripts/application.js

``` javascript
//= require bootstrap-datepicker
```

You can fine tune the included files to suit your needs.

```javascript
//= require bootstrap-datepicker/core
//= require bootstrap-datepicker/locales/bootstrap-datepicker.es.js
//= require bootstrap-datepicker/locales/bootstrap-datepicker.fr.js
```

## Using bootstrap-datepicker-rails

Just use the simple ```data-provide='datepicker'``` attribute.

```html
<input type="text" data-provide='datepicker' >
```

Or call datepicker() with any selector.

```html
<input type="text" class='datepicker' >

<script type="text/javascript">
  $(document).ready(function(){
    $('.datepicker').datepicker();
  });
</script>
```

Examples:

http://eternicode.github.io/bootstrap-datepicker/

There are a lot of options you can pass to datepicker(). They are documented at [https://github.com/eternicode/bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker)

## Updating the assets

Please use the rake task to update the assets.

Examples :

```bash
rake update             # Update the assets with the latest tag source code on master
rake update v1.4.0      # Update the assets with the specified tag source code
```

## Questions? Bugs?

Use Github Issues.

## License
Copyright (c) 2014 Gonzalo Rodríguez-Baltanás Díaz

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
