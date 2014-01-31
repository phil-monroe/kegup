class Org < ActiveRecord::Base
  validates :name, presence: true

  has_many :org_beer_selections
  has_many :beers, through: :org_beer_selections

  has_many :taps, -> { order("id ASC") }
  has_many :kegs

  has_many :org_user_memberships
  has_many :users, through: :org_user_memberships

  accepts_nested_attributes_for :org_beer_selections, allow_destroy: true
  accepts_nested_attributes_for :taps, allow_destroy: true
  accepts_nested_attributes_for :kegs, allow_destroy: true
  accepts_nested_attributes_for :org_user_memberships, allow_destroy: true


  def kegmeisters
    @kegmeisters ||= self.users.merge(OrgUserMembership.kegmeisters)
  end

  def has_empty_taps?
    taps.map(&:empty?).include?(true)
  end

  def suggested_beer
    beer = self.beers.to_a.dup
    beer.delete self.kegs.backlogged.map(&:beer)
    beer.delete self.taps.map{ |tap| tap.keg.beer }
    beer.delete self.kegs.finished.limit(2).map(&:beer)
    beer.sample(3, random: Random.new(self.updated_at.to_i))
  end
end
