class Keg < ActiveRecord::Base
  belongs_to :org, touch: true
  belongs_to :beer

  has_one :current_tap, class_name: 'Tap', inverse_of: :keg

  scope :backlogged, -> { where("tapped_date IS NULL AND finished_date IS NULL").order('updated_at DESC') }
  scope :finished, -> { where("finished_date < ?",Time.now).order('finished_date DESC') }

  def name
    "#{short_name} - #{self.beer.name}"
  end

  def short_name
    "Keg #{self.id} "
  end
end
