class Tap < ActiveRecord::Base
  belongs_to :org
  belongs_to :keg

  validates :name, uniqueness: { scope: :org_id }

end
