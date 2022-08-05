require 'rails_helper'

RSpec.describe 'Tagモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:acquaintance) { create(:acquaintance, user: user) }

  describe 'バリデーションテスト' do
    it "tagの保存が有効" do
      tag = FactoryBot.build(:tag)
      expect(tag.valid?).to eq(true)
    end
    context "nameカラム" do
      it "Not null制限" do
        tag = FactoryBot.build(:tag, name: nil)
        expect(tag.valid?).to eq(false)
      end
      it "空でないこと" do
        tag = FactoryBot.build(:tag, name: " ")
        expect(tag.valid?).to eq(false)
      end
      it "255文字以内であること" do
        tag = FactoryBot.build(:tag, name: Faker::Lorem.characters(number: 256))
        expect(tag.valid?).to eq(false)
      end
    end
  end

  describe 'アソシエーションテスト' do
    context 'Taggingモデルとの関係' do
      it "1:N関係" do
        expect(Tag.reflect_on_association(:taggings).macro).to eq :has_many
      end
      it "Tagの削除に伴う削除が有効" do
        topic = FactoryBot.create(:topic, user: user)
        tag = topic.tags.first
        expect {
          tag.destroy
        }.to change(Tag, :count).by(-1)
      end
    end
    context 'Tagモデルとの関係' do
      it "N:N関係" do
        expect(Tag.reflect_on_association(:topics).macro).to eq :has_many
      end
    end
  end
end