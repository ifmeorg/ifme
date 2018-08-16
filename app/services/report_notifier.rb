class ReportNotifier
    attr_reader :ally_id, :current_user, :notifier
  
    def initialize(args)
      @ally_id = args[:ally_id]
      @current_user = args[:current_user]
    end

    private

    def send_email_report(recipient)
        ReportMailer.report_email(recipient.id, data).deliver_now
    end
  
end
  