require 'sprockets'
require 'compass/sprite_importer'

module CompassRails
  class SpriteImporter < Compass::SpriteImporter
    attr_reader :root

    def initialize(root)
      @root = root
    end

    def find(uri, options)
      if old = super(uri, options)
        context = options[:sprockets][:context]
        self.class.files(uri).each do |file|
          relative_path = Pathname.new(file).relative_path_from(Pathname.new(root))
          begin
            pathname = context.resolve(relative_path.to_s)
            context.depend_on_asset(pathname)
          rescue Sprockets::FileNotFound

          end
        end
      end

      old
    end
  end
end
