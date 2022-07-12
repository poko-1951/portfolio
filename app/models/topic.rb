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
  has_many   :events,        through: :schedules
  has_many   :acquaintances, through: :stocks

  def self.tag_search(search_tag)
    Topic.where(tag_id: search_tag)
  end

  def stocked_by?(user)
    stocks.exists?(user_id: user.id, acquaintance_id: nil)
  end

end
