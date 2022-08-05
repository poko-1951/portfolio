require 'rails_helper'

RSpec.describe 'Eventモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:acquaintance) { create(:acquaintance, user: user) }
  let(:event) { create(:event, user: user) }

  describe 'バリデーションテスト' do
    it "eventの保存が有効" do
      expect(event.valid?).to eq(true)
    end
    context "titleカラム" do
      it "Not null制限" do
        event = FactoryBot.build(:event, title: nil, user: user)
        expect(event.valid?).to eq(false)
      end
      it "空でないこと" do
        event = FactoryBot.build(:event, title: " ", user: user)
        expect(event.valid?).to eq(false)
      end
      it "255文字以内であること" do
        event = FactoryBot.build(:event, title: Faker::Lorem.characters(number: 256), user: user)
        expect(event.valid?).to eq(false)
      end
    end
    context "contentカラム" do
      it "Not null制限" do
        event = FactoryBot.build(:event, content: nil, user: user)
        expect(event.valid?).to eq(false)
      end
      it "空でないこと" do
        event = FactoryBot.build(:event, content: " ", user: user)
        expect(event.valid?).to eq(false)
      end
      it "255文字以内であること" do
        event = FactoryBot.build(:event, content: Faker::Lorem.characters(number: 256), user: user)
        expect(event.valid?).to eq(false)
      end
    end
    context "placeカラム" do
      it "Not null制限" do
        event = FactoryBot.build(:event, place: nil, user: user)
        expect(event.valid?).to eq(false)
      end
      it "空でないこと" do
        event = FactoryBot.build(:event, place: " ", user: user)
        expect(event.valid?).to eq(false)
      end
      it "255文字以内であること" do
        event = FactoryBot.build(:event, place: Faker::Lorem.characters(number: 256), user: user)
        expect(event.valid?).to eq(false)
      end
    end
    context "start_atカラム" do
      it "Not null制限" do
        event = FactoryBot.build(:event, start_at: nil, user: user)
        expect(event.valid?).to eq(false)
      end
      it "空でないこと" do
        event = FactoryBot.build(:event, start_at: " ", user: user)
        expect(event.valid?).to eq(false)
      end
    end
    context "end_atカラム" do
      it "Not null制限" do
        event = FactoryBot.build(:event, end_at: nil, user: user)
        expect(event.valid?).to eq(false)
      end
      it "空でないこと" do
        event = FactoryBot.build(:event, end_at: " ", user: user)
        expect(event.valid?).to eq(false)
      end
      it "start_atより前になっていないこと" do
        event = FactoryBot.build(:event, start_at: Faker::Time.between(from: DateTime.now, to: DateTime.now + 1), end_at: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now), user: user)
        expect(event.valid?).to eq(false)
      end
    end
  end

  describe 'アソシエーションテスト' do
    context 'Userモデルとの関係' do
      it "N:1関係" do
        expect(Event.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
    context 'Acquaintanceモデルとの関係' do
      it "N:N関係" do
        expect(Event.reflect_on_association(:acquaintances).macro).to eq :has_many
      end
    end
    context 'Scheduleモデルとの関係' do
      it "1:N関係" do
      expect(Event.reflect_on_association(:schedules).macro).to eq :has_many
      end
      it "Eventの削除に伴う削除が有効" do
        FactoryBot.create(:schedule, event: event, acquaintance: acquaintance)
        expect { event.destroy }.to change(Schedule, :count).by(-1)
      end
    end
  end
end