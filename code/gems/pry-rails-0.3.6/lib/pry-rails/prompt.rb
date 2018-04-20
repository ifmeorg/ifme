module PryRails
  class Prompt
    class << self
      def formatted_env
        if Rails.env.production?
          bold_env = Pry::Helpers::Text.bold(Rails.env)
          Pry::Helpers::Text.red(bold_env)
        elsif Rails.env.development?
          Pry::Helpers::Text.green(Rails.env)
        else
          Rails.env
        end
      end

      def project_name
        File.basename(Rails.root)
      end
    end
  end

  RAILS_PROMPT = [
    proc do |target_self, nest_level, pry|
      "[#{pry.input_array.size}] " \
        "[#{Prompt.project_name}][#{Prompt.formatted_env}] " \
        "#{Pry.config.prompt_name}(#{Pry.view_clip(target_self)})" \
        "#{":#{nest_level}" unless nest_level.zero?}> "
    end,
    proc do |target_self, nest_level, pry|
      "[#{pry.input_array.size}] " \
        "[#{Prompt.project_name}][#{Prompt.formatted_env}] " \
        "#{Pry.config.prompt_name}(#{Pry.view_clip(target_self)})" \
        "#{":#{nest_level}" unless nest_level.zero?}* "
    end
  ]

  Pry::Prompt::MAP["rails"] = {
    value: RAILS_PROMPT,
    description: "Includes the current Rails environment and project folder name.\n" \
                 "[1] [project_name][Rails.env] pry(main)>"
  }
end
