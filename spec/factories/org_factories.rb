FactoryGirl.define do
  factory :org do
    sequence(:name) {|n| "Org #{n}" }
    reminder_email 'kegmaster@identified.com'
  end
end