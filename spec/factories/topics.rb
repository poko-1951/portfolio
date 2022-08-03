FactoryBot.define do
  factory :topic do
    title   { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraph }
    after(:create) do |topic|
      create(:tagging, topic: topic, tag: create(:tag))
    end
  end
end