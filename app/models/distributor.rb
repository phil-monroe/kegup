class Distributor < ActiveRecord::Base
  has_many :org_distributors
  has_many :orgs, through: :org_distributors


  has_many :distributor_beer_selections
  has_many :beers, through: :distributor_beer_selections

  accepts_nested_attributes_for :distributor_beer_selections, allow_destroy: true

end
