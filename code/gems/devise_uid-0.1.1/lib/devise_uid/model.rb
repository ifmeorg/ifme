module Devise
  module Models
    module Uid
      extend ActiveSupport::Concern

      included do
        before_save :generate_uid
      end

      module ClassMethods
        def uid
          loop do
            token = Devise.friendly_token
            break token unless to_adapter.find_first({ :uid => token })
          end
        end
      end

      private

      def generate_uid
        self.uid = self.class.uid if self.uid.nil?
      end
    end
  end
end
