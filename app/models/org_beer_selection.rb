class OrgBeerSelection < ActiveRecord::Base
  validates :beer_id, presence: true
  validates :org_id, presence: true
  validates :org_id, uniqueness: { scope: :beer_id }
end
