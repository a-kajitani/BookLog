
FactoryBot.define do
  factory :impression do
    body { "とても参考になった" }
    association :user
    association :section
  end
end
