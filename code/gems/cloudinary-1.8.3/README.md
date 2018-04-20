[![Build Status](https://travis-ci.org/cloudinary/cloudinary_gem.svg?branch=master)](https://travis-ci.org/cloudinary/cloudinary_gem)
Cloudinary
==========

Cloudinary is a cloud service that offers a solution to a web application's entire image management pipeline. 

Easily upload images to the cloud. Automatically perform smart image resizing, cropping and conversion without installing any complex software. Integrate Facebook or Twitter profile image extraction in a snap, in any dimension and style to match your website’s graphics requirements. Images are seamlessly delivered through a fast CDN, and much much more. 

Cloudinary offers comprehensive APIs and administration capabilities and is easy to integrate with any web application, existing or new.

Cloudinary provides URL and HTTP based APIs that can be easily integrated with any Web development framework. 

For Ruby on Rails, Cloudinary provides a GEM for simplifying the integration even further.

## Getting started guide
![More](http://res.cloudinary.com/cloudinary/image/upload/see_more_bullet.png)  **Take a look at our [Getting started guide of Ruby on Rails](https://cloudinary.com/documentation/rails_integration#getting_started_guide)**.

## Setup ######################################################################

To install the Cloudinary Ruby GEM, run:

    $ gem install cloudinary

If you use Rails 3.x or higher, edit your `Gemfile`, add the following line and run `bundle install`

    gem 'cloudinary'

Or in Rails 2.x, edit your `environment.rb` and add:

    config.gem 'cloudinary'

If you would like to use our optional integration module of image uploads with ActiveRecord using `CarrierWave`, install CarrierWave GEM:

Rails 3.x: edit your `Gemfile` and run `bundle install`:

    gem 'carrierwave'
    gem 'cloudinary'

Rails 2.x environment.rb:

    config.gem 'carrierwave', :version => '~> 0.4.10'
    config.gem 'cloudinary'


*Note: The CarrierWave GEM should be loaded before the Cloudinary GEM.*

## Try it right away

Sign up for a [free account](https://cloudinary.com/users/register/free) so you can try out image transformations and seamless image delivery through CDN.

*Note: Replace `demo` in all the following examples with your Cloudinary's `cloud name`.*  

Accessing an uploaded image with the `sample` public ID through a CDN:

    http://res.cloudinary.com/demo/image/upload/sample.jpg

![Sample](https://res.cloudinary.com/demo/image/upload/w_0.4/sample.jpg "Sample")

Generating a 150x100 version of the `sample` image and downloading it through a CDN:

    http://res.cloudinary.com/demo/image/upload/w_150,h_100,c_fill/sample.jpg

![Sample 150x100](https://res.cloudinary.com/demo/image/upload/w_150,h_100,c_fill/sample.jpg "Sample 150x100")

Converting to a 150x100 PNG with rounded corners of 20 pixels: 

    http://res.cloudinary.com/demo/image/upload/w_150,h_100,c_fill,r_20/sample.png

![Sample 150x150 Rounded PNG](https://res.cloudinary.com/demo/image/upload/w_150,h_100,c_fill,r_20/sample.png "Sample 150x150 Rounded PNG")

For plenty more transformation options, see our [image transformations documentation](https://cloudinary.com/documentation/image_transformations).

Generating a 120x90 thumbnail based on automatic face detection of the Facebook profile picture of Bill Clinton:
 
    http://res.cloudinary.com/demo/image/facebook/c_thumb,g_face,h_90,w_120/billclinton.jpg
    
![Facebook 90x120](https://res.cloudinary.com/demo/image/facebook/c_thumb,g_face,h_90,w_120/billclinton.jpg "Facebook 90x200")

For more details, see our documentation for embedding [Facebook](https://cloudinary.com/documentation/facebook_profile_pictures) and [Twitter](https://cloudinary.com/documentation/twitter_profile_pictures) profile pictures. 


## Usage

### Configuration

Each request for building a URL of a remote cloud resource must have the `cloud_name` parameter set. 
Each request to our secure APIs (e.g., image uploads, eager sprite generation) must have the `api_key` and `api_secret` parameters set. See [API, URLs and access identifiers](https://cloudinary.com/documentation/api_and_access_identifiers) for more details.

Setting the `cloud_name`, `api_key` and `api_secret` parameters can be done either directly in each call to a Cloudinary method or by globally setting using a YAML configuration file.

Cloudinary looks for an optional file named cloudinary.yml, which should be located under the `config` directory of your Rails project. 
It contains settings for each of your deployment environments. You can always override the values specified in `cloudinary.yml` by passing different values in specific Cloudinary calls.

You can [download your customized cloudinary.yml](https://cloudinary.com/console/cloudinary.yml) configuration file using our Management Console.

Passing the parameters manually looks like this:

``` ruby
auth = {
  cloud_name: "somename",
  api_key:    "1234567890",
  api_secret: "FooBarBaz123"
}

Cloudinary::Uploader.upload("my_picture.jpg", auth)
```


### Embedding and transforming images

Any image uploaded to Cloudinary can be transformed and embedded using powerful view helper methods:

The following example generates an image of an uploaded `sample` image while transforming it to fill a 100x150 rectangle:

    cl_image_tag("sample.jpg", :width => 100, :height => 150, :crop => :fill)

Another example, emedding a smaller version of an uploaded image while generating a 90x90 face detection based thumbnail: 

    cl_image_tag("woman.jpg", :width => 90, :height => 90, 
                 :crop => :thumb, :gravity => :face)

You can provide either a Facebook name or a numeric ID of a Facebook profile or a fan page.  
             
Embedding a Facebook profile to match your graphic design is very simple:

    facebook_profile_image_tag("billclinton.jpg", :width => 90, :height => 130, 
                               :crop => :fill, :gravity => :north_west)
                           
Same goes for Twitter:

    twitter_name_profile_image_tag("billclinton.jpg")

![More](http://res.cloudinary.com/cloudinary/image/upload/see_more_bullet.png) **See [our documentation](https://cloudinary.com/documentation/rails_image_manipulation) for more information about displaying and transforming images in Rails**.                                         



### Upload

Assuming you have your Cloudinary configuration parameters defined (`cloud_name`, `api_key`, `api_secret`), uploading to Cloudinary is very simple.
    
The following example uploads a local JPG to the cloud: 
    
    Cloudinary::Uploader.upload("my_picture.jpg")
        
The uploaded image is assigned a randomly generated public ID. The image is immediately available for download through a CDN:

    cl_image_tag("abcfrmo8zul1mafopawefg.jpg")
        
    http://res.cloudinary.com/demo/image/upload/abcfrmo8zul1mafopawefg.jpg

You can also specify your own public ID:    
    
    Cloudinary::Uploader.upload("http://www.example.com/image.jpg", :public_id => 'sample_remote')

    cl_image_tag("sample_remote.jpg")

    http://res.cloudinary.com/demo/image/upload/sample_remote.jpg


![More](http://res.cloudinary.com/cloudinary/image/upload/see_more_bullet.png) **See [our documentation](https://cloudinary.com/documentation/rails_image_upload) for plenty more options of uploading to the cloud from your Ruby code or directly from the browser**.


### CarrierWave Integration

**Note:** Starting from version 1.1.0 the CarrierWave database format has changed to include the resource type and storage type. The new functionality
is backward compatible with the previous format. To use the old format override `use_extended_identifier?` in the Uploader and return `false`.

Cloudinary's Ruby GEM includes an optional plugin for [CarrierWave](https://github.com/jnicklas/carrierwave). If you already use CarrierWave, simply include `Cloudinary::CarrierWave` to switch to cloud storage and image processing in the cloud. 

    class PictureUploader < CarrierWave::Uploader::Base    
        include Cloudinary::CarrierWave        
        ...  
    end

![More](http://res.cloudinary.com/cloudinary/image/upload/see_more_bullet.png) **For more details on CarrierWave integration see [our documentation](https://cloudinary.com/documentation/rails_carrierwave)**.

We also published an interesting blog post about [Ruby on Rails image uploads with CarrierWave and Cloudinary](https://cloudinary.com/blog/ruby_on_rails_image_uploads_with_carrierwave_and_cloudinary).

#### Neo4j integration

Starting from version 1.1.1 Cloudinary's Ruby GEM supports the use of carrierwave with Neo4j.

### JavaScript support library

During the installation or update of the Cloudinary GEM, the latest Cloudinary JavaScript library is automatically fetched and bundled with the GEM.

To use the JavaScript files you need to include them in your application, for example:

```
<%= javascript_include_tag("jquery.ui.widget", "jquery.iframe-transport", 
                           "jquery.fileupload", "jquery.cloudinary") %>
```

Alternatively, if you use Asset Pipeline, simply edit your application.js file and add the following line:

```
//= require cloudinary
```

To automatically set-up Cloudinary's configuration, include the following line in your view or layout:

```
<%= cloudinary_js_config %>
```

#### Uploading images from the browser

The Cloudinary JavaScript library utilizes the Blueimp File Upload library to support image uploading from the browser. See the [documentation](https://cloudinary.com/documentation/jquery_image_upload) for more details.

|Important|
|---------|
|Starting with version 2.0 of the Cloudinary JavaScript library, the Cloudinary extension to the Blueimp File Upload library is no longer initialized automatically. Instead you need to explicitly set it up as described below.|

To initialize the File Upload library with Cloudinary include the following code in your page:

```javascript
$(function() {
      if($.fn.cloudinary_fileupload !== undefined) {
        $("input.cloudinary-fileupload[type=file]").cloudinary_fileupload();
      }
    });
```


(`cloudinary_fileupload()` internally calls Blueimp's `fileupload()` so there's no need to call both.)

### Samples

You can find our simple and ready-to-use samples projects, along with documentation in the [samples folder](https://github.com/cloudinary/cloudinary_gem/tree/master/samples). 
Please consult with the [README file](https://github.com/cloudinary/cloudinary_gem/blob/master/samples/README.md), for usage and explanations.

## Additional resources ##########################################################

Additional resources are available at:

* [Website](https://cloudinary.com)
* [Interactive demo](https://demo.cloudinary.com/default)
* [Documentation](https://cloudinary.com/documentation)
* [Knowledge Base](https://support.cloudinary.com/hc/en-us)
* [Documentation for Ruby on Rails integration](https://cloudinary.com/documentation/rails_integration)
* [Ruby on Rails image upload documentation](https://cloudinary.com/documentation/rails_image_upload)
* [Ruby on Rails image manipulation documentation](https://cloudinary.com/documentation/rails_image_manipulation)
* [Image transformations documentation](https://cloudinary.com/documentation/image_transformations)

## Support

You can [open an issue through GitHub](https://github.com/cloudinary/cloudinary_gem/issues).

Contact us [https://cloudinary.com/contact](https://cloudinary.com/contact)

Stay tuned for updates, tips and tutorials: [Blog](https://cloudinary.com/blog), [Twitter](https://twitter.com/cloudinary), [Facebook](https://www.facebook.com/Cloudinary).


## License #######################################################################

Released under the MIT license. 


