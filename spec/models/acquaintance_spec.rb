require "rails_helper"

RSpec.describe "Acquaintanceモデルのテスト", type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:acquaintance) { create(:acquaintance, user: user) }
  let(:event) { create(:event, user: user) }

  describe "バリデーションテスト" do
    it "acquaintanceの保存が有効" do
      expect(acquaintance.valid?).to eq(true)
    end
    context "nameカラム" do
      it "Not null制限" do
        acquaintance = FactoryBot.build(:acquaintance, name: nil, user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "空でないこと" do
        acquaintance = FactoryBot.build(:acquaintance, name: " ", user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "255文字以内であること" do
        acquaintance = FactoryBot.build(:acquaintance, name: Faker::Lorem.characters(number: 256), user: user)
        expect(acquaintance.valid?).to eq(false)
      end
    end
    context "characterカラム" do
      it "Not null制限" do
        acquaintance = FactoryBot.build(:acquaintance, character: nil, user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "空でないこと" do
        acquaintance = FactoryBot.build(:acquaintance, character: " ", user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "255文字以内であること" do
        acquaintance = FactoryBot.build(:acquaintance, character: Faker::Lorem.characters(number: 256), user: user)
        expect(acquaintance.valid?).to eq(false)
      end
    end
    context "relationshipカラム" do
      it "Not null制限" do
        acquaintance = FactoryBot.build(:acquaintance, relationship: nil, user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "空でないこと" do
        acquaintance = FactoryBot.build(:acquaintance, relationship: " ", user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "255文字以内であること" do
        acquaintance = FactoryBot.build(:acquaintance, relationship: Faker::Lorem.characters(number: 256), user: user)
        expect(acquaintance.valid?).to eq(false)
      end
    end
    context "likeカラム" do
      it "Not null制限" do
        acquaintance = FactoryBot.build(:acquaintance, like: nil, user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "空でないこと" do
        acquaintance = FactoryBot.build(:acquaintance, like: " ", user: user)
        expect(acquaintance.valid?).to eq(false)
      end
      it "255文字以内であること" do
        acquaintance = FactoryBot.build(:acquaintance, like: Faker::Lorem.characters(number: 256), user: user)
        expect(acquaintance.valid?).to eq(false)
      end
    end
  end

  describe "アソシエーションテスト" do
    context "Userモデルとの関係" do
      it "N:1関係" do
        expect(Acquaintance.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context "Topicモデルとの関係" do
      it "N:N関係" do
        expect(Acquaintance.reflect_on_association(:topics).macro).to eq :has_many
      end
    end
    context "Stockモデルとの関係" do
      it "1:N関係" do
        expect(Acquaintance.reflect_on_association(:stocks).macro).to eq :has_many
      end
      it "Acquaintanceの削除に伴う削除が有効" do
        FactoryBot.create(:stock, user: user, topic: topic, acquaintance: acquaintance)
        expect { acquaintance.destroy }.to change(Stock, :count).by(-1)
      end
    end
    context "Eventモデルとの関係" do
      it "N:N関係" do
        expect(Acquaintance.reflect_on_association(:events).macro).to eq :has_many
      end
    end
    context "Scheduleモデルとの関係" do
      it "1:N関係" do
        expect(Acquaintance.reflect_on_association(:schedules).macro).to eq :has_many
      end
      it "Acquaintanceの削除に伴う削除が有効" do
        FactoryBot.create(:schedule, event: event, acquaintance: acquaintance)
        expect { acquaintance.destroy }.to change(Schedule, :count).by(-1)
      end
    end
  end
end
