# == Schema Information
#
# Table name: topics
#
#  id         :integer          not null, primary key
#  content    :string           not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_topics_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :topic do
    title   { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraph }
    after(:create) do |topic|
      create(:tagging, topic: topic, tag: create(:tag))
    end
  end
end
