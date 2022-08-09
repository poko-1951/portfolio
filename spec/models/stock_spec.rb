# == Schema Information
#
# Table name: stocks
#
#  id              :integer          not null, primary key
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  acquaintance_id :integer
#  topic_id        :integer          not null
#  user_id         :integer          not null
#
# Indexes
#
#  index_stocks_on_acquaintance_id  (acquaintance_id)
#  index_stocks_on_topic_id         (topic_id)
#  index_stocks_on_user_id          (user_id)
#
# Foreign Keys
#
#  acquaintance_id  (acquaintance_id => acquaintances.id)
#  topic_id         (topic_id => topics.id)
#  user_id          (user_id => users.id)
#
require "rails_helper"

RSpec.describe "Stockモデルのテスト", type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:acquaintance) { create(:acquaintance, user: user) }

  describe "バリデーションテスト" do
    it "stockの保存が有効" do
      stock = FactoryBot.build(:stock, user: user, topic: topic, acquaintance: acquaintance)
      expect(stock.valid?).to eq(true)
    end
  end

  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1関係" do
        expect(Stock.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Topicモデルとの関係" do
      it "N:1関係" do
        expect(Stock.reflect_on_association(:topic).macro).to eq :belongs_to
      end
    end
    context "Acquaintanceモデルとの関係" do
      it "N:1関係" do
        expect(Stock.reflect_on_association(:acquaintance).macro).to eq :belongs_to
      end
    end
  end
end
