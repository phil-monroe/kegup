class Keg < ActiveRecord::Base
  belongs_to :org
  belongs_to :beer
end
