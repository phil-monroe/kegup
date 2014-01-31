class OrgMailer < ActionMailer::Base
  default from: 'notification@kegup.com'


  def tap_empty_email(org)
    if org.present?
      addresses = org.kegmeisters.map(&:email)
      addresses = org.reminder_email if addresses.blank?

      mail(to: addresses, subject: 'BEER TAP EMPTY!!!') if addresses.present?
    end
  end


  def bother_kegmeister_email(org, user)
    if org.present? && org.has_empty_taps? && user.present?
      @user = user
      addresses = org.kegmeisters.map(&:email)
      addresses = org.reminder_email if addresses.blank?

      mail(to: addresses, subject: 'BEER TAP EMPTY!!!') if addresses.present?
    end
  end

  def keg_tapped_email(org, tap)
    if org.present? && tap.present? && tap.keg.present?
      addresses = org.users.map(&:email)
      addresses = org.reminder_email if addresses.blank?

      @org = org
      @tap = tap
      @beer = tap.keg.beer

      mail(to: addresses, subject: "New On Tap: #{@beer.name}!") if addresses.present?
    end
  end

end
