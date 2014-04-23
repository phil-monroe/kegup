FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "first-#{n}" }
    sequence(:last_name) {|n| "last-#{n}" }
    sequence(:email) {|n| "email-#{n}@test.com" }

    ignore do
      favorite_beer_count 3
    end

    after(:create) do |user, evaluator|
      create_list(:favorite_beer, evaluator.favorite_beer_count, user: user)
    end
  end
end