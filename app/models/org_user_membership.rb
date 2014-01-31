class OrgUserMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :org, touch: true

  scope :kegmeisters, -> { where(is_kegmeister: true) }
end
