FactoryBot.define do
  factory :topic do
    title { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraph }
    user
  end
end