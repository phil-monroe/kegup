class ReminderMailer < ActionMailer::Base
  default from: 'notification@kegup.com'


  def tap_empty_email(org)
    mail(to: org.reminder_email, subject: 'BEER TAP EMPTY!!!') if org.present? and org.reminder_email.present?
  end

end
