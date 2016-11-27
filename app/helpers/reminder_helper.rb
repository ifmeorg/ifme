module ReminderHelper
  def print_reminders(data)
    return_this = ''

    if data.active_reminders.any?
      return_this += '<div class="small_margin_top">'
      return_this += '<i class="fa fa-bell small_margin_right"></i>'
      reminder_names = data.active_reminders.map(&:name)
      return_this += reminder_names.to_sentence(
        two_words_connector: t('support.array.words_connector')
      )
      return_this += '</div>'
    end

    return return_this.html_safe
  end
end
