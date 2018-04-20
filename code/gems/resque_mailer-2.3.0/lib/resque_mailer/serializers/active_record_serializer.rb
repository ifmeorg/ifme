module Resque
  module Mailer
    module Serializers
      module ActiveRecordSerializer
        extend self

        def serialize(*args)
          args.map do |arg|
            if arg.is_a?(ActiveRecord::Base)
              { "class_name" => arg.class.name, "id" => arg.id }
            else
              arg
            end
          end
        end

        def deserialize(data)
          data.map do |arg|
            if arg.is_a?(Hash) && arg.has_key?("class_name") && arg.has_key?("id")
              arg["class_name"].constantize.find(arg["id"])
            else
              arg
            end
          end
        end
      end
    end
  end
end
