class ReminderMailer < ActionMailer::Base
  default from: 'notification@kegup.com'


  def tap_empty_email(org)
    if org.present?
      addresses = org.kegmeisters.map(&:email)
      addresses = org.reminder_email if addresses.blank?

      mail(to: addresses, subject: 'BEER TAP EMPTY!!!') if addresses.present?
    end
  end

end
