klass = if defined?(Sass::Rails::SassTemplate)
  Sass::Rails::SassTemplate
else
  Sprockets::SassTemplate
end

klass.class_eval do
  def evaluate(context, locals, &block)
    # Use custom importer that knows about Sprockets Caching
    cache_store =
      if defined?(Sprockets::SassProcessor::CacheStore)
        Sprockets::SassProcessor::CacheStore.new(sprockets_cache_store, context.environment)
      else
        Sprockets::SassCacheStore.new(context.environment)
      end

    paths  = context.environment.paths.map { |path| CompassRails::SpriteImporter.new(path) }
    paths += context.environment.paths.map { |path| sass_importer(context, path) }
    paths += ::Rails.application.config.sass.load_paths

    options = CompassRails.sass_config.merge( {
      :filename => eval_file,
      :line => line,
      :syntax => syntax,
      :cache_store => cache_store,
      :importer => sass_importer(context, context.pathname),
      :load_paths => paths,
      :sprockets => {
        :context => context,
        :environment => context.environment
      }
    })

    engine = ::Sass::Engine.new(data, options)

    engine.dependencies.map do |dependency|
      filename = dependency.options[:filename]
      if filename.include?('*') # Handle sprite globs
        image_path = Rails.root.join(Compass.configuration.images_dir).to_s
        Dir[File.join(image_path, filename)].each do |f|
          context.depend_on(f)
        end
      else
        context.depend_on(filename)
      end
    end

    engine.render
  rescue ::Sass::SyntaxError => e
    # Annotates exception message with parse line number
    context.__LINE__ = e.sass_backtrace.first[:line]
    raise e
  end

  private

  def sass_importer_artiy
    @sass_importer_artiy ||= sass_importer_class.instance_method(:initialize).arity
  end

  def sass_importer(context, path)
    case sass_importer_artiy.abs
    when 1
      sass_importer_class.new(path)
    else
      sass_importer_class.new(context, path)
    end
  end

  # if using haml-rails, self.class.parent = Haml::Filters (which doesn't have an implementation)
  def sass_importer_class
    @sass_importer_class ||= if defined?(self.class.parent::SassImporter)
                               self.class.parent::SassImporter
                             elsif defined?(Sass::Rails::SassTemplate)
                               Sass::Rails::SassImporter
                             else
                               Sprockets::SassImporter
                             end
  end

  def sprockets_cache_store
    cache =
      case Rails.application.config.assets.cache_store
      when :null_store
        Sprockets::Cache::NullStore.new
      when :memory_store, :mem_cache_store
        Sprockets::Cache::MemoryStore.new
      else
        path = "#{Rails.application.config.root}/tmp/cache/assets/#{Rails.env}"

        Sprockets::Cache::FileStore.new(path)
      end

    Sprockets::Cache.new(cache, Rails.logger)
  end
end
