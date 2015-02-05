FactoryGirl.define do
  factory :role do
    name        'Regular'
    description 'Can read and create posts. Can update and destroy own posts'
  end

  factory :user do
    login { |n| "test.user#{n}" }
    first_name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
  end
end
