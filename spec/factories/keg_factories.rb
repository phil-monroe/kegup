FactoryGirl.define do
  factory :keg do
    beer { create(:beer) }
  end
end