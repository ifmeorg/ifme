# frozen_string_literal: true

module ReminderHelper
  def print_reminders(data)
    reminders = ''

    if active_reminders?(data)
      names_arr = data.active_reminders.map(&:name)
      reminders = format_reminders(names_arr)
    end

    reminders.html_safe
  end

  private

  def active_reminders?(data)
    data.methods.include?(:active_reminders) && data.active_reminders&.any?
  end

  def format_reminders(reminder_names)
    reminders = '<div>'
    reminders += '<i class="fa fa-bell smallMarginRight"></i>'
    reminders += join_names(reminder_names)
    reminders += '</div>'
    reminders
  end

  def join_names(reminder_names)
    reminder_names.to_sentence(
      two_words_connector: t('support.array.words_connector')
    )
  end
end
