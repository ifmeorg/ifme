# frozen_string_literal: true
module IsVisibleConcern
  extend ActiveSupport::Concern

  included do
    scope :is_visible, -> { where(visible: true) }
  end
end
