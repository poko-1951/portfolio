FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.sentence }
    user
    topic
  end
end