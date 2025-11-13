# spec/factories/users.rb
FactoryBot.define do
  factory :user do
    name { "testuser" }
    email { "test@example.com" }
    password { "testuser" }
    password_confirmation { "testuser" }
    admin { false }

    trait :admin do
      name { "adminuser" }
      email { "admin@example.com" }
      admin { true }
    end

    trait :second_user do
      name { "testuser2" }
      email { "test2@example.com" }
    end
  end
end