FactoryGirl.define do
  factory :user do
    sequence(:first_name) {|n| "first-#{n}" }
    sequence(:last_name) {|n| "last-#{n}" }
    sequence(:email) {|n| "email-#{n}@test.com" }
  end
end