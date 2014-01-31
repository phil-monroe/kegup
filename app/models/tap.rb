class Tap < ActiveRecord::Base
  belongs_to :org, touch: true
  belongs_to :keg

  validates :name, uniqueness: { scope: :org_id }
  validates :keg_id, uniqueness: { scope: :id }

  scope :available, -> { where(keg_id: nil) }

  before_save :touch_keg_if_tapped
  before_save :send_reminder_email
  before_save :send_keg_tapped_email

  def finish
    self.keg_id = nil
    save
  end

  def empty?
    keg.nil?
  end

  private
  def touch_keg_if_tapped
    if self.keg_id_changed?
      if self.keg.present?
        self.keg.tapped_date = Time.now
        self.keg.finished_date = nil
        self.keg.save!
      end
      Keg.find(self.keg_id_was).touch(:finished_date) if self.keg_id_was.present?
    end
  end

  def send_reminder_email
    OrgMailer.tap_empty_email(self.org).deliver if self.org.present? && self.keg_id_changed? && self.keg_id.nil?
  end

  def send_keg_tapped_email
    OrgMailer.keg_tapped_email(self.org, self).deliver if self.org.present? && self.keg_id_changed? && self.keg_id.present?
  end

end
