FactoryGirl.define do

  factory :person do
    full_name "Tori Kelly"
    email "tori.kelly@example.com"
    phone "123456789"
  end

  trait :with_no_full_name do
    full_name nil
  end
end
