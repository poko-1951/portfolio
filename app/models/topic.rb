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
class Topic < ApplicationRecord
  belongs_to :user
  has_many   :stocks,        dependent: :destroy
  has_many   :taggings,      dependent: :destroy
  has_many   :comments,      dependent: :destroy
  has_many   :tags,          through: :taggings
  has_many   :acquaintances, through: :stocks
  has_many   :notifications,   dependent: :destroy

  validates :title,   presence: true
  validates :content, presence: true

  def self.tag_search(search_tag)
    Topic.where(tag_id: search_tag)
  end

  def stocked_by?(user)
    stocks.exists?(user_id: user.id, acquaintance_id: nil)
  end

  # お気に入り登録通知
  def create_notification_favorite(current_user)
    # すでに「お気に入り登録」されているか検索
    favorited_self = Notification.where(["visitor_id = ? and visited_id = ? and topic_id = ? and action = ? ", current_user.id, user_id, id, 'favorite'])
    # お気に入り登録されていない場合のみ、通知を作成
    if favorited_self.blank?
      notification = current_user.active_notifications.new(
        topic_id: id,
        visited_id: user_id,
        action: 'favorite'
      )
      # 自分の投稿をお気に入り登録する場合は、通知済みとする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  # コメント通知
  def create_notification_comment(current_user, comment_id)
    # 自分以外にコメントしている人をすべて取得し、全員に通知を送る
    temp_ids = Comment.select(:user_id).where(topic_id: id).where.not(user_id: current_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment(current_user, comment_id, temp_id['user_id'])
    end
    # まだ誰もコメントしていない場合は、投稿者に通知を送る
    save_notification_comment(current_user, comment_id, user_id) if temp_ids.blank?
  end

  def save_notification_comment(current_user, comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_user.active_notifications.new(
      topic_id: id,
      comment_id: comment_id,
      visited_id: visited_id,
      action: 'comment'
    )
    # 自分の投稿に対するコメントの場合は、通知済みとする
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end
end
