FactoryGirl.define do
  factory :beer do
    sequence(:name) {|n| "Beer #{n}" }
    sequence(:brewed_by) {|n| "Brewer #{n}" }
    style { Beer::STYLES.sample }
    abv 5.0
    description "A tasty beer"
  end
end