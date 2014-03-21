class Org < ActiveRecord::Base
  validates :name, presence: true

  has_many :org_distributors, dependent: :destroy
  has_many :distributors, through: :org_distributors
  has_many :beers, through: :distributors


  has_many :taps, -> { order("taps.id ASC") }, dependent: :destroy
  has_many :kegs, dependent: :destroy

  has_many :org_user_memberships, dependent: :destroy
  has_many :users, through: :org_user_memberships

  accepts_nested_attributes_for :taps, allow_destroy: true
  accepts_nested_attributes_for :kegs, allow_destroy: true
  accepts_nested_attributes_for :org_user_memberships, allow_destroy: true
  accepts_nested_attributes_for :org_distributors, allow_destroy: true


  def kegmeisters
    @kegmeisters ||= self.users.merge(OrgUserMembership.kegmeisters)
  end

  def has_empty_taps?
    taps.map(&:empty?).include?(true)
  end

  def suggested_beer
    beers_table=Beer.arel_table

    backlogged_beer_ids = kegs.backlogged.pluck(:beer_id)
    tapped_beer_ids     = taps.joins(:keg).pluck(:beer_id)
    available_beers     = beers.where(beers_table[:id].not_in(backlogged_beer_ids + tapped_beer_ids))

    beer_histogram = available_beers.inject(Hash.new) {|hist, beer| hist[beer] = 0; hist }
    users.includes(:beers).each do |user|
      user.beers.each do |beer|
        beer_histogram[beer] += 1 if beer_histogram[beer].present?
      end
    end

    # beer_histogram.each {|b, c| puts "#{b.name} => #{c}"}

    rng = Random.new(self.updated_at.to_i)

    beer_histogram
    .to_a
    .shuffle(random: rng)
    .sort_by(&:last)
    .last(3)
    .map(&:first)
    .reverse!
  end
  add_method_tracer :suggested_beer

  def to_param
    "#{self.id}-#{self.name}".parameterize
  end
end
