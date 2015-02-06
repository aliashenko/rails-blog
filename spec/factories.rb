FactoryGirl.define do
  factory :user do
    login { |n| "test.user#{n}" }
    first_name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
    role 'Regular'
  end

  factory :admin, class: 'User' do
    login { |n| "test.user#{n}" }
    first_name { |n| "user #{n}" }
    email { |n| "user-#{n}@example.com" }
    password { |n| "user-#{n}" }
    role 'Admin'
  end

  factory :post do
    title { |n| "Title ##{n}" }
    content { |n| "Content of #{n} post" }
    association :user
  end
end
