# == Schema Information
#
# Table name: events
#
#  id         :integer          not null, primary key
#  content    :string           default("未設定"), not null
#  end        :datetime         not null
#  place      :string           default("未設定"), not null
#  start      :datetime         not null
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

  validates :title,   presence: true
  validates :content, presence: true
  validates :place,   presence: true
  validate  :start_end_check

  #時間の矛盾を防ぐ
  def start_end_check
    if self.start.present? && self.end.present?
      errors.add(:end, "が開始時刻を上回っています。正しく記入してください。") if self.start > self.end
    end
  end

end
