# spec/factories/books.rb
FactoryBot.define do
  factory :book do
    title { "テスト本" }
    author { "名前" }
    association :user
  end
end