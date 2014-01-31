class Beer < ActiveRecord::Base
  STYLES = ['IPA', 'Amber', 'Lager', 'Pale Ale', 'Marzen', 'Altbier', 'American Pale Ale', 'Porter', 'California Common / Steam', 'Amber Ale', 'Witbier', 'Abbey Dubbel', 'Imperial IPA', 'Pale Lager', 'Strong Ale', 'English Pale Ale', 'Marzen / Oktoberfest', 'Bohemian / Czech Pilsener', 'Hefeweizen', 'Cider', 'Belgian Ale']
  validates :name, presence: true
  validates :style, inclusion: { in: STYLES }

  has_many :distributor_beer_selections
  has_many :distributors, through: :distributor_beer_selections
  has_many :orgs, through: :distributors

  mount_uploader :image, ImageUploader

  def image_url *args
    # Cache will be invalidated every time this Beer is updated or every day
    Rails.cache.fetch([:images, self, :image_url, *args], expires_in: 1.day) do
      super(*args)
    end
  end

end
