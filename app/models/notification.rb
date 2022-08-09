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
class Notification < ApplicationRecord
  default_scope -> { order(created_at: :desc) }

  belongs_to :topic,   optional: true
  belongs_to :comment, optional: true
  belongs_to :visitor, class_name: 'User'
  belongs_to :visited, class_name: 'User'
end
