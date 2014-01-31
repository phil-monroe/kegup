class OrgUserMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :org

  scope :kegmeisters, -> { where(is_kegmeister: true) }
end
