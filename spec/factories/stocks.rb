# == Schema Information
#
# Table name: stocks
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  acquaintance_id :integer
#  topic_id        :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_stocks_on_acquaintance_id  (acquaintance_id)
#  index_stocks_on_topic_id         (topic_id)
#  index_stocks_on_user_id          (user_id)
#
# Foreign Keys
#
#  acquaintance_id  (acquaintance_id => acquaintances.id)
#  topic_id         (topic_id => topics.id)
#  user_id          (user_id => users.id)
#
FactoryBot.define do
  factory :stock do
  end
end
