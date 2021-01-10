FactoryBot.define do
  factory :comic do
    sequence(:name) { |n| "example#{n}" }
    volume { 1 }
    image { "MyString" }
    association :user
  end
end
