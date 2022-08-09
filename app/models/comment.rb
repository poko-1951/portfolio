# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  comment    :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  topic_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_topic_id  (topic_id)
#  index_comments_on_user_id   (user_id)
#
# Foreign Keys
#
#  topic_id  (topic_id => topics.id)
#  user_id   (user_id => users.id)
#
class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :topic
  has_many   :notifications, dependent: :destroy

  validates :comment, presence: true
end
