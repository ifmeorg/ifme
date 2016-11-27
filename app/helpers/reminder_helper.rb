module ReminderHelper
  def print_reminders(data)
    reminders = ''

    if data.active_reminders.any?
      reminders = format_reminders(data.active_reminders.map(&:name))
    end

    reminders.html_safe
  end

  private

  def format_reminders(reminder_names)
    reminders = '<div class="small_margin_top">'
    reminders += '<i class="fa fa-bell small_margin_right"></i>'
    reminders += reminder_names.to_sentence(
      two_words_connector: t('support.array.words_connector')
    )
    reminders += '</div>'
    reminders
  end
end
