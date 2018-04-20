# Webpacker Lite
![Gem Version](https://badge.fury.io/rb/webpacker_lite.svg) [![Build Status](https://travis-ci.org/shakacode/webpacker_lite.svg?branch=master)](https://travis-ci.org/shakacode/webpacker_lite)

*A slimmer version of Webpacker*

We will soon merge Webpacker Lite changes back into [Webpacker, per this discussion](https://github.com/rails/webpacker/issues/464#issuecomment-310986140). Any changes will be minor if you're using Webpacker Lite. In the meantime, we have something _stable_ for React on Rails projects!

------

Webpacker Lite provides similar webpack enabled view helpers from [Webpacker](https://github.com/rails/webpacker).

For example, these view helpers allow your application's layout to easily reference JavaScript and CSS files created by your Webpack setup, taking into account differences in the Rails environments. With these helpers, there is no reason for Webpack created assets to run through the [Asset Pipeline](http://guides.rubyonrails.org/asset_pipeline.html), as was done in React on Rails 7.x and earlier.

[React on Rails](https://github.com/shakacode/react_on_rails) version 8 and greater defaults to using Webpacker Lite. You may use this gem outside of React on Rails projects.

If you like this project, show your support by giving us a star!

# Why Fork?

> Everything should be made as simple as possible, but not simpler.

[Albert Einstein on Wikiquote](https://en.wikiquote.org/wiki/Albert_Einstein)

Why did [ShakaCode](http://www.shakacode.com) fork [rails/webpacker](https://github.com/rails/webpacker)? 

3 reasons:

1. React on Rails needed only the helpers in Webpacker to obtain the correct file path or relative URL to Webpack created assets, given different Rails environments, fingerprinting of assets, hot-reloading, etc.
2. We preferred a simpler configuration to get the core functionality needed. You configure just one thing: The directory within `/public` where Webpack will create the manifest and output file. Then you configure your Webpack config to generate a simple manifest that maps the base output names to the possibly fingerprinted versions. Note, unlike Webpacker, Webpacker Lite wants your manifest to **NOT** contain any host information.
3. We needed the ability to quickly make changes needed by [react_on_rails](https://github.com/shakacode/react_on_rails)

For more details on how this project differs from Webpacker and why we forked, please see [Webpacker Lite: Why Fork Webpacker?](https://blog.shakacode.com/webpacker-lite-why-fork-webpacker-f0a7707fac92).

# NEWS
 
* 2017-05-29: React on Rails 8.0.0 shipped, defaulting to webpacker_lite.

## Installation

The best way to see the installation of webpacker_lite is to use the generator for React on Rails 8.0.0 or greater. Otherwise, add the gem and create the configuration file described below.

## Overview

1. Configure the `config/webpacker_lite.yml` file, as described below. You will specify the name of the manifest file and the output directory used by step 2. The directories you specify are within your `/public` directory.
2. Configure Webpack to use an output path that matches your (`webpack_public_output_dir`) that you configured in your `/config/webpacker_lite.yml`. Use the [webpack-manifest-plugin](https://www.npmjs.com/package/webpack-manifest-plugin) to generate a manifest.
3. Use the view helpers on your layouts to provide the webpack generated files. Note, these are the same names used by [rails/webpacker](https://github.com/rails/webpacker).
   These `output` names are **NOT** the actual file names, as the file name may have a [fingerprint](http://guides.rubyonrails.org/asset_pipeline.html#what-is-fingerprinting-and-why-should-i-care-questionmark).
   ```erb
   <%# app/views/layouts/application.html.erb %>
   <%= javascript_pack_tag('main') %>
   <%= stylesheet_pack_tag('main') %>
   ```
4. When hot-reloading, the extract-text-plugin (extracted CSS from being inlined in the JavaScript)is not supported. Therefore, all your hot-reloaded Webpack-compiled CSS will be inlined and we will skip the CSS file by default. If you're not worried about hot-reloading for your CSS, use the `enabled_when_hot_loading: true` option. 

   ```erb
   <%= stylesheet_pack_tag('main', enabled_when_hot_loading: true) %> <% # Default is false %>
   ```
   
For more details on the helper documentation, see the Ruby comments in [lib/webpacker_lite/helper.rb](lib/webpacker_lite/helper.rb) and please submit PRs here to help us improve the docs!

## Configuration
Webpacker Lite takes one configuration file: `config/webpacker_lite.yml` used to configure two required values and a couple optional values. Note, this file is configured like `config/database.yml` in that you place the values beneath the name of the Rails.env. 

### Mandatory Configuration within `config/webpacker_lite.yml` 

1. `webpack_public_output_dir`: The output directory of both the manifest and the webpack static generated files within the `/public` directory.

Note, placing output files within the Rails `/public` directory is not configurable.

### Optional Configuration within `config/webpacker_lite.yml` 
1. `manifest`: The manifest file name 
1. `hot_reloading_host`: The name of the hot reloading `webpack-dev-server` including the port
2. `hot_reloading_enabled_by_default`: If hot reloading should default to true

### Hot Reloading Notes

Do not put the output server in your `manifest.json` file. The rails view helpers will automatically prepend the hot_reloading_host to the asset path.

### Example Configuration `/config/webpacker_lite.yml`

This example config shows how we use different output directories for the webpack generated assets per the type of environment. This is extremely convenient when you want to log redux messages in development but not in your tests.

```yaml
# /config/webpacker_lite.yml
# Note: Base output directory of /public is assumed for static files
default: &default
  manifest: manifest.json  
  # Used in your webpack configuration. Must be created in the
  # webpack_public_output_dir folder.
  
development:
  <<: *default
  # generated files for development, in /public/webpack/development
  webpack_public_output_dir: webpack/development
  
  # Default is localhost:3500. You can specify the protocol if needed. Defaults to http://.
  hot_reloading_host: localhost:3500
  
  # Developer note: considering removing this option so it can ONLY be turned by using an ENV value.
  # Default is false, ENV 'HOT_RELOADING' will always override 
  hot_reloading_enabled_by_default: false 
  
test:
  <<: *default
  # generated files for tests, in /public/webpack/test   
  webpack_public_output_dir: webpack/test

production:
  <<: *default
  # generated files for tests, in /public/webpack/production
  webpack_public_output_dir: webpack/production
```

## Example for Development vs Hot Reloading vs Production Mode

**erb file**

```erb
  <% # app/views/layouts/application.html.erb %>
  <%= javascript_pack_tag('main') %>
  <%= stylesheet_pack_tag('main') %>
```

**html file**

```html
  <!-- In test mode -->
  <script src="/webpack/test/main.js"></script>
  <link rel="stylesheet" media="screen" href="/webpack/test/main-0bd141f6d9360cf4a7f5.js">
  
  <!-- In development mode -->
  <script src="/webpack/development/main.js"></script>
  <link rel="stylesheet" media="screen" href="/webpack/development/main-0bd141f6d9360cf4a7f5.js">
  
  <!-- In development mode with hot reloading, using the webpack-dev-server -->
  <script src="http://localhost:8080/webpack/development/main.js"></script>
  <!-- Note, there's no stylesheet tag by default, as your CSS should be inlined in your JS. -->
  
  <!-- In production mode -->
  <script src="/webpack/production/main-0bd141f6d9360cf4a7f5.js"></script>
  <link rel="stylesheet" media="screen" href="/webpack/production/main-dc02976b5f94b507e3b6.css">
```

## Other Helpers: Getting the asset path

The `asset_pack_path` helper provides the path of any given asset that's been compiled by webpack.
Note, the real file path is the subdirectory of the public.

For example, if you want to create a `<link rel="prefetch">` or `<img />`
for an asset used in your pack code you can reference them like this in your view,

```erb
<img src="<%= asset_pack_path 'calendar.png' %>" />
<% # => <img src="/webpack/calendar.png" /> %>
<% # real file path "public/webpack/calendar.png" /> %>
```

The `pack_path` is the same as the `asset_pack_path` except that the Rails `asset_path` is not called on the file name. This is used by server rendering, as the `asset_path` is designed for browsers to access assets.

## Webpack Helper
You may use the [React on Rails NPM Package](https://www.npmjs.com/package/react-on-rails), [react-on-rails/webpackConfigLoader](https://github.com/shakacode/react_on_rails/blob/master/webpackConfigLoader.js) to provide your Webpack config with easy access to the YAML settings. Even if you don't use the NPM package, you can use that file to inspire your Webpack configuration.

## Rake Tasks

### Examples

To see available webpacker_lite rake tasks:

```
rake webpacker_lite
```

If you are using different directories for the output paths per RAILS_ENV, this is how you'd delete the files created for tests: 
```
RAILS_ENV=test rake webpacker_lite:clobber
```

## Differences from Webpacker

1. Configuration setup of an optional single file `/config/webpacker_lite.yml`
2. Webpacker helpers expect the manifest to contain the server URL when hot reloading. Webpacker Lite expects the manifest **to never contain any host information**.

## Hot Reloading

1. Tell Rails and Webpacker Lite that you're hot reloading by setting the ENV value of `HOT_RELOADING=YES` if you are not hot reloading by default by setting the `hot_reloading_enabled_by_default` key in your config file.
1. By default, the `stylesheet_pack_tag` helper will not create a tag when hot reloading is enabled. Per the note above, when hot-reloading, the extract-text-plugin (extracted CSS from being inlined in the JavaScript)is not supported. Therefore, all your hot-reloaded Webpack-compiled CSS will be inlined and we will skip the CSS file by default.

   ```erb
   <%= stylesheet_pack_tag('main', enabled_when_hot_loading: true) %> <% # Default is false %>
   ```

## Prerequisites
* Ruby 2+
* Rails 4.2+
