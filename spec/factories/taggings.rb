FactoryBot.define do
  factory :tagging do
    association :topic
    association :tag
  end
end