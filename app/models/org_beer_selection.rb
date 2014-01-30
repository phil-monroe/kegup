class OrgBeerSelection < ActiveRecord::Base
  validates :beer_id, presence: true
  validates :org_id, presence: true
  validates :org_id, uniqueness: { scope: :beer_id, message: "available beer has already been added."  }

  belongs_to :org
  belongs_to :beer
end
