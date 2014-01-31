class Beer < ActiveRecord::Base
  STYLES = ['IPA', 'Amber', 'Lager', 'Pale Ale', 'Marzen', 'Altbier', 'American Pale Ale', 'Porter', 'California Common / Steam', 'Amber Ale', 'Witbier', 'Abbey Dubbel', 'Imperial IPA', 'Pale Lager', 'Strong Ale']
  validates :name, presence: true
  validates :style, inclusion: { in: STYLES }

  has_many :org_beer_selections
  has_many :orgs, through: :org_beer_selections
end
