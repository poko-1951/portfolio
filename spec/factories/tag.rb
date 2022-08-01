FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.sentence(word_count: 2) }
  end
end