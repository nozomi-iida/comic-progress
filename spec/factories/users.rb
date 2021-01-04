FactoryBot.define do
  factory :user do
    first_name { "Nozomi" }
    last_name { "Iida" }
    sequence(:email) { |n| "test#{n}@example.com" } # シーケンスを使う
  end
end
