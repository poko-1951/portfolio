FactoryBot.define do
  factory :event do
    title   { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraph }
    place   { Faker::Lorem.characters(number: 10) }
    start   { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    # end     { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end