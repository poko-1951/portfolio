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
end
