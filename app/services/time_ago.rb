# frozen_string_literal: true

require 'action_view'
require 'action_view/helpers'
include ActionView::Helpers::DateHelper

class TimeAgo
  class << self
    def formatted_ago(time_with_zone)
      if time_with_zone < 1.week.ago
        I18n.l(time_with_zone.to_date, format: :long)
      else
        I18n.t('common.time_ago', date: time_ago_in_words(time_with_zone))
      end
    end

    def created_or_edited(model)
      formatted_created = formatted_ago(model.created_at)
      formatted_updated = formatted_ago(model.updated_at)

      if model.created_at != model.updated_at
        edited(formatted_created, formatted_updated)
      else
        I18n.t('created', created_at: formatted_created).html_safe
      end
    end

    private

    def edited(formatted_created, formatted_updated)
      if formatted_created == formatted_updated
        I18n.t('edited', created_at: formatted_created).html_safe
      else
        I18n.t('edited_updated_at', created_at: formatted_created,
                                    updated_at: formatted_updated).html_safe
      end
    end
  end
end
