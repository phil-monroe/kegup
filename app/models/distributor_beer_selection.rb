class DistributorBeerSelection < ActiveRecord::Base
  validates :beer_id, presence: true
  validates :distributor_id, presence: true
  validates :distributor_id, uniqueness: { scope: :beer_id, message: "available beer has already been added."  }

  belongs_to :distributor, touch: true
  belongs_to :beer
end
