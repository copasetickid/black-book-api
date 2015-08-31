FactoryGirl.define do
  factory :user do
    email "tori.kelly@example.com"
	password_digest "MyString"
  end

   trait :with_no_password do
    password nil
  end
end
