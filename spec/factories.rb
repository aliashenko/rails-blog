FactoryGirl.define do
  factory :user do
    login { |n| "test.user#{n}" }
    first_name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
    role 'Regular'
  end
end
