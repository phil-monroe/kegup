class Org < ActiveRecord::Base
  validates :name, presence: true

  has_many :org_beer_selections
  has_many :beers, through: :org_beer_selections
end
