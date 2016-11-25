class ApplicationMailer < ActionMailer::Base
  include ActionView::Helpers::UrlHelper
  default from: ENV['SMTP_ADDRESS']
	layout 'mailer'

  	def can_notify(user, notify_type)
		if notify_type == 'comment_notify'
			return user.comment_notify || user.comment_notify.nil?
		elsif notify_type == 'ally_notify'
			return user.ally_notify || user.ally_notify.nil?
		elsif notify_type == 'group_notify'
			return user.group_notify || user.group_notify.nil?
		elsif notify_type == 'meeting_notify'
			return user.meeting_notify || user.meeting_notify.nil?
		end

		return false
	end
end
