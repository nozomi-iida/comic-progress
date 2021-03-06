FactoryBot.define do
  factory :user do
    first_name { "Nozomi" }
    last_name { "Iida" }
    sequence(:email) { |n| "test#{n}@test.com" } # シーケンスを使う
    password { "111111" }
    password_confirmation { "111111" }
    activated { true }
    activated_at { Time.now }
  end
end
