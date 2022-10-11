module IsVisible
  extend ActiveSupport::Concern

  included do
    scope :is_visible, lambda { where(visible: true) }
  end
end