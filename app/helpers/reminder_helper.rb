# frozen_string_literal: true
module ReminderHelper
  def print_reminders(data)
    return '' unless reminders?(data)

    names_arr = data.active_reminders.map(&:name)
    if data[:add_to_google_cal]
      names_arr.push(t('medications.form.add_to_google_cal'))
    end
    format_reminders(names_arr).html_safe
  end

  private

  def reminders?(data)
    active_reminders?(data) || data[:add_to_google_cal]
  end

  def active_reminders?(data)
    data.methods.include?(:active_reminders) && data.active_reminders&.any?
  end

  def format_reminders(reminder_names)
    reminders = join_names(reminder_names)
    "<div><i class=\"fa fa-bell smallMarginRight\"></i>#{reminders}</div>"
  end

  def join_names(reminder_names)
    reminder_names.to_sentence(
      two_words_connector: t('support.array.words_connector')
    )
  end
end
