FactoryGirl.define do
  factory :org do
    sequence(:name) {|n| "Org #{n}" }
    reminder_email 'kegmeister@identified.com'
  end
end