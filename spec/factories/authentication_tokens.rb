FactoryGirl.define do
  factory :authentication_token do
    body "token"
	user nil
	last_used_at DateTime.current
	ip_address "MyString"
	user_agent "MyString"
  end
end
