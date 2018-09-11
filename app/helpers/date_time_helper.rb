# frozen_string_literal: true

module DateTimeHelper
  def format_date(date_str)
    begin
      date_formatted = date_str.to_date
    rescue
      date_formatted = Date.strptime(date_str, '%m/%d/%Y')
    end
    I18n.l(date_formatted, format: :long)
  end

  def format_time(time_str)
    I18n.l(time_str.to_time, format: '%I:%M %p')
  end
end
