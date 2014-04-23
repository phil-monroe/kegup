FactoryGirl.define do
  factory :favorite_beer, :class => Users::FavoriteBeer do
    beer { create(:beer) }
    user { create(:user) }
  end
end