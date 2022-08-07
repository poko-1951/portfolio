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
