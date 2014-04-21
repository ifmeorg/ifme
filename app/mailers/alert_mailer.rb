class AlertMailer < ActionMailer::Base
	include Resque::Mailer
  	default from: "admin@julianguyen.org"

  	def alert_email(user)
    	@user = user
    	@url  = 'http://example.com/login'
    	mail(to: @user.email, subject: 'Welcome to My Awesome Site')
  	end
end
