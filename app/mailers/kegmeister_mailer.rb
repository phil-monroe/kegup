class KegmeisterMailer < ActionMailer::Base
  default from: 'notification@kegup.com'


  def bother_email(org, user)
    if org.present? && org.has_empty_taps? && user.present?
      @user = user
      addresses = org.kegmeisters.map(&:email)
      addresses = org.reminder_email if addresses.blank?

      mail(to: addresses, subject: 'BEER TAP EMPTY!!!') if addresses.present?
    end
  end

end
