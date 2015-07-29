class Beer < ActiveRecord::Base
  UNKNOWN_STYLE = 'Unknown'
  STYLES = ['IPA', 'Amber', 'Lager', 'Pale Ale', 'Marzen', 'Altbier', 'American Pale Ale', 'Porter', 'California Common / Steam', 'Amber Ale', 'Witbier', 'Abbey Dubbel', 'Imperial IPA', 'Pale Lager', 'Strong Ale', 'English Pale Ale', 'Marzen / Oktoberfest', 'Bohemian / Czech Pilsener', 'Hefeweizen', 'Cider', 'Belgian Ale', 'Stout', 'Wheat Beer', 'Cream Ale', 'Saison / Farmhouse Ale', 'Kölsch', 'Pilsner', 'Gose'].sort + [UNKNOWN_STYLE]

  validates :name, presence: true
  validates :style, inclusion: { in: STYLES }

  has_many :distributor_beer_selections
  has_many :distributors, through: :distributor_beer_selections
  has_many :orgs, through: :distributors

  has_many :favorite_beers, class_name: Users::FavoriteBeer
  has_many :users, through: :favorite_beers

  mount_uploader :image, ImageUploader
  
  before_create do
    self.name      = self.name.titleize
    self.brewed_by = self.brewed_by.titleize
  end

  def image_url *args
    # Cache will be invalidated every time this Beer is updated or every day
    Rails.cache.fetch([:images, self, :image_url, *args], expires_in: 1.day) do
      super(*args)
    end
  end

end
