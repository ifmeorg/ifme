module NotificationMailerHelper
  def reminder_mailer(model, subject_text)
    @model = model
    @user = @model.user
    subject = I18n.t(
      subject_text,
      name: @model.name
    )
    mail(to: @user.email, subject: subject)
  end
end
