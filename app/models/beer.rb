class Beer < ActiveRecord::Base
  STYLES = ['IPA', 'Amber', 'Lager', 'Pale Ale', 'Marzen']
  validates :name, presence: true
  validates :style, inclusion: { in: STYLES }

  has_many :org_beer_selections
  has_many :orgs, through: :org_beer_selections
end
