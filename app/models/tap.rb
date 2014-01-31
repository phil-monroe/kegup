class Tap < ActiveRecord::Base
  belongs_to :org
  belongs_to :keg

  validates :name, uniqueness: { scope: :org_id }
  validates :keg_id, uniqueness: { scope: :id }

  scope :available, -> { where(keg_id: nil) }

  before_save :touch_keg_if_tapped
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
end
