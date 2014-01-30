class Keg < ActiveRecord::Base
  belongs_to :org
  belongs_to :beer
  has_one :current_tap, class_name: 'Tap', inverse_of: :keg
end
