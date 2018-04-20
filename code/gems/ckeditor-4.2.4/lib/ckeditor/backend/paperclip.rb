module Ckeditor
  module Backend
    module Paperclip
      def self.included(base)
        base.send(:include, InstanceMethods)
        base.send(:extend, ClassMethods)
      end

      module ClassMethods
        def self.extended(base)
          base.class_eval do
            before_validation :extract_content_type
            before_create :extract_dimensions

            delegate :url, :path, :styles, :content_type, to: :data
          end
        end
      end

      module InstanceMethods
        def geometry
          @geometry ||= ::Paperclip::Geometry.from_file(file)
        end

        protected

        def file
          @file ||= data.respond_to?(:queued_for_write) ? data.queued_for_write[:original] : data.to_file
        end

        def extract_dimensions
          if image? && has_dimensions?
            self.width = geometry.width
            self.height = geometry.height
          end
        end

        def extract_content_type
          path = file.nil? ? nil : file.path
          self.data_content_type = Utils::ContentTypeDetector.new(path).detect
        end
      end
    end
  end
end
