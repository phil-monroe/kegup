class OrgUserMembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :org

  scope :kegmasters, -> { where(is_kegmaster: true) }
end
