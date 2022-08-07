FactoryBot.define do
  factory :acquaintance do
    name         { Faker::Name.name }
    relationship { Faker::Lorem.characters(number: 10) }
    character    { Faker::Lorem.characters(number: 10) }
    like         { Faker::Lorem.characters(number: 10) }
  end
end
