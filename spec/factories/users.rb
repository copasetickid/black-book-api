FactoryGirl.define do
  factory :user do
    email "tori.kelly@example.com"
	 password_digest "MyString"
	
  	after(:create) do |user, evaluator|
  		create(:authentication_token, user: user)
  	end
  end

   trait :with_no_password do
    password nil
  end
end
