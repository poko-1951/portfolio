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
require "rails_helper"

RSpec.describe "Scheduleモデルのテスト", type: :model do
  let(:user) { create(:user) }
  let(:acquaintance) { create(:acquaintance, user: user) }
  let(:event) { create(:event, user: user) }

  describe "バリデーションテスト" do
    it "scheduleの保存が有効" do
      schedule = FactoryBot.build(:schedule, event: event, acquaintance: acquaintance)
      expect(schedule.valid?).to eq(true)
    end
  end

  describe "アソシエーションテスト" do
    context "Eventモデルとの関係" do
      it "N:1関係" do
        expect(Schedule.reflect_on_association(:event).macro).to eq :belongs_to
      end
    end
    context "Acquaintanceモデルとの関係" do
      it "N:1関係" do
        expect(Schedule.reflect_on_association(:acquaintance).macro).to eq :belongs_to
      end
    end
  end
end
