class Distributor < ActiveRecord::Base
  has_many :org_distributors
  has_many :orgs, through: :org_distributors

end
