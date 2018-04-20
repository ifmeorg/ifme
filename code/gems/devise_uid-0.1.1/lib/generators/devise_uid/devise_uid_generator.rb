module DeviseUid
  module Generators
    class DeviseUidGenerator < Rails::Generators::NamedBase
      namespace "devise_uid"

      desc "Add :uid directive in the given model. Also generate migration for ActiveRecord"

      def inject_devise_invitable_content
        path = File.join("app", "models", "#{file_path}.rb")
        inject_into_file(path, "uid, :", :after => "devise :") if File.exists?(path)
      end

      hook_for :orm
    end
  end
end
