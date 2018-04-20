require 'compass/compiler'
module Compass
  class Compiler
    attr_accessor :sass_options
    STYLESHEET = /stylesheet/
    def sass_options
      @sass_options[:custom] ||= {}
      @sass_options[:custom] = {:resolver => ::Sass::Rails::Resolver.new(CompassRails.context)}
      @sass_options[:load_paths] ||= []
      unless @sass_options[:load_paths].any? {|k| k.is_a?(::Sass::Rails::Importer) }
        ::CompassRails.sprockets.paths.each do |path|
          next unless path.to_s =~ STYLESHEET
          Dir["#{path}/**/*"].each do |pathname|
            # args are: sprockets environment, the logical_path ex. 'stylesheets', and the full path name for the render
            context = ::CompassRails.context.new(::CompassRails.sprockets, File.basename(path), Pathname.new(pathname))
            @sass_options[:load_paths] << ::Sass::Rails::Importer.new(context)
          end
        end
      end
      @sass_options
    end

  end
end
