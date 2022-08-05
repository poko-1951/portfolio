require 'rails_helper'

RSpec.describe 'Taggingモデルのテスト', type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:tag) { create(:tag) }

  describe 'バリデーションテスト' do
    it "topicの保存が有効" do
      tagging = FactoryBot.build(:tagging, topic: topic, tag: tag)
      expect(tagging.valid?).to eq(true)
    end
  end

  describe 'アソシエーションテスト' do
    context "Topicモデルとの関係" do
      it "N:1関係" do
        expect(Tagging.reflect_on_association(:topic).macro).to eq :belongs_to
      end
    end
    context "Tagモデルとの関係" do
      it "N:1関係" do
        expect(Tagging.reflect_on_association(:tag).macro).to eq :belongs_to
      end
    end
  end
end