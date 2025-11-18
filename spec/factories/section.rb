FactoryBot.define do
  factory :section do
    content { "テスト用の章" }
    association :user
    association :book
  end
end