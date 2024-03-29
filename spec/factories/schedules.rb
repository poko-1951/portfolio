# == Schema Information
#
# Table name: schedules
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  acquaintance_id :integer          not null
#  event_id        :integer          not null
#
# Indexes
#
#  index_schedules_on_acquaintance_id  (acquaintance_id)
#  index_schedules_on_event_id         (event_id)
#
# Foreign Keys
#
#  acquaintance_id  (acquaintance_id => acquaintances.id)
#  event_id         (event_id => events.id)
#
FactoryBot.define do
  factory :schedule do
  end
end
