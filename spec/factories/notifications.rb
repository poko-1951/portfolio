# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  action     :string           default(" "), not null
#  checked    :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  comment_id :integer
#  topic_id   :integer
#  visited_id :integer          not null
#  visitor_id :integer          not null
#
# Indexes
#
#  index_notifications_on_comment_id  (comment_id)
#  index_notifications_on_topic_id    (topic_id)
#  index_notifications_on_visited_id  (visited_id)
#  index_notifications_on_visitor_id  (visitor_id)
#
FactoryBot.define do
  factory :notification do
    visitor_id { 1 }
    visited_id { 1 }
    topic_id { 1 }
    comment_id { 1 }
    action { "MyString" }
    checked { false }
  end
end
