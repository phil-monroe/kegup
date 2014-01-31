class OrgDistributor < ActiveRecord::Base
  belongs_to :org, touch: true
  belongs_to :distributor
end
