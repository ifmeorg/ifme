module SomeRailtie
  class Railtie < ::Rails::Engine

    initializer "some_railtie.factories", :after => "factory_bot.set_factory_paths" do
      FactoryBot.definition_file_paths << File.expand_path('../factories', __FILE__)
    end
  end
end