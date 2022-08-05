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
class Event < ApplicationRecord
  belongs_to :user
  has_many   :schedules,     dependent: :destroy
  has_many   :acquaintances, through: :schedules

  validates :title,   presence: true, length: { maximum: 255 }
  validates :content, presence: true, length: { maximum: 255 }
  validates :place,   presence: true, length: { maximum: 255 }
  validates :start_at,   presence: true
  validates :end_at,   presence: true
  validate  :start_end_check

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start_at.present? && self.end_at.present?
      errors.add(:end_at) if self.start_at >= self.end_at
    end
  end

end
