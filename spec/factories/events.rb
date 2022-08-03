# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  content    :string           default("未設定"), not null
#  end_at     :datetime         not null
#  place      :string           default("未設定"), not null
#  start_at   :datetime         not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_events_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
FactoryBot.define do
  factory :event do
    title   { Faker::Lorem.characters(number: 10) }
    content { Faker::Lorem.paragraph }
    place   { Faker::Lorem.characters(number: 10) }
    start   { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
    # end     { Faker::Time.between(from: DateTime.now - 1, to: DateTime.now) }
  end
end
