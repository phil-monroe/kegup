FactoryGirl.define do
  factory :tap do
    sequence(:name) {|n| "Tap #{n}" }
  end
end