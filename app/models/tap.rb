class Tap < ActiveRecord::Base
  belongs_to :org
  belongs_to :keg

  validates :name, uniqueness: { scope: :org_id }
  validates :keg_id, uniqueness: { scope: :id }

  before_save :touch_keg_if_tapped
  def touch_keg_if_tapped
    if self.keg_id_changed?
      self.keg.touch(:tapped_date) if self.keg.present?
      Keg.find(self.keg_id_was).touch(:finished_date) if self.keg_id_was.present?
    end
  end
end
