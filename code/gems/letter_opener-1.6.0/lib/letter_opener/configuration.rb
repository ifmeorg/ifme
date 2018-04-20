module LetterOpener
  class Configuration
    attr_accessor :location, :message_template

    def initialize
      @location = Rails.root.join('tmp', 'letter_opener') if defined?(Rails)
      @message_template = 'default'
    end
  end
end
