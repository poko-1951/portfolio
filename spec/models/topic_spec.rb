require 'rails_helper'

RSpec.describe 'Topicモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:acquaintance) { create(:acquaintance, user: user) }

  describe 'バリデーションテスト' do
    it "topicの保存が有効" do
      expect(topic.valid?).to eq(true)
    end
    context "titleカラム" do
      it "Not null制限" do
        topic = FactoryBot.build(:topic, title: nil)
        expect(topic.valid?).to eq(false)
      end
      it "空でないこと" do
        topic = FactoryBot.build(:topic, title: " ")
        expect(topic.valid?).to eq(false)
      end
      it "255文字以内であること" do
        topic = FactoryBot.build(:topic, title: Faker::Lorem.characters(number: 256))
        expect(topic.valid?).to eq(false)
      end
    end
    context "contentカラム" do
      it "Not null制限" do
        topic = FactoryBot.build(:topic, content: nil)
        expect(topic.valid?).to eq(false)
      end
      it "空でないこと" do
        topic = FactoryBot.build(:topic, content: " ")
        expect(topic.valid?).to eq(false)
      end
    end

    describe 'アソシエーションテスト' do
      context 'Userモデルとの関係' do
        it "N:1関係" do
          expect(Topic.reflect_on_association(:user).macro).to eq :belongs_to
        end
      end
      context 'Acquaintanceモデルとの関係' do
        it "N:N関係" do
          expect(Topic.reflect_on_association(:acquaintances).macro).to eq :has_many
        end
      end
      context 'Stockモデルとの関係' do
        it "1:N関係" do
        expect(Topic.reflect_on_association(:stocks).macro).to eq :has_many
        end
        it "Topicの削除に伴う削除が有効" do
          FactoryBot.create(:stock, user: user, topic: topic, acquaintance: acquaintance)
          expect { topic.destroy

          }.to change(Stock, :count).by(-1)
        end
      end
      context 'Tagモデルとの関係' do
        it "N:N関係" do
          expect(Topic.reflect_on_association(:tags).macro).to eq :has_many
        end
      end
      context 'Taggingモデルとの関係' do
        it "1:N関係" do
          expect(Topic.reflect_on_association(:taggings).macro).to eq :has_many
        end
        it "Topicの削除に伴う削除が有効" do
          topic = FactoryBot.create(:topic, user: user)
          expect {
            topic.destroy
          }.to change(Tagging, :count).by(-1)
        end
      end
      context 'Commentモデルとの関係' do
        it "1:N関係" do
          expect(Topic.reflect_on_association(:comments).macro).to eq :has_many
        end
        it "Topicの削除に伴う削除が有効" do
          FactoryBot.create(:comment, user: user, topic: topic)
          expect { topic.destroy }.to change(Comment, :count).by(-1)
        end
      end
    end
  end
end