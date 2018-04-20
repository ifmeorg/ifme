require 'sprockets/static_compiler'
module Sprockets
  class StaticCompiler
    cattr_accessor :generated_sprites
    self.generated_sprites = {}
    def write_manifest_with_sprites(manifest)
      write_manifest_without_sprites(manifest.merge(self.class.generated_sprites))
    end
    alias_method_chain :write_manifest, :sprites
  end
end

