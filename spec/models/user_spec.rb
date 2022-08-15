# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string           default("")
#  email_receiving_activation :boolean          default(TRUE), not null
#  encrypted_password         :string           default("")
#  is_deleted                 :boolean          default(FALSE), not null
#  name                       :string           default("")
#  remember_created_at        :datetime
#  reset_password_sent_at     :datetime
#  reset_password_token       :string
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
require "rails_helper"

RSpec.describe "Userモデルのテスト", type: :model do
  let(:user) { create(:user) }
  let(:topic) { create(:topic, user: user) }
  let(:acquaintance) { create(:acquaintance, user: user) }

  describe "バリデーションテスト" do
    it "userの保存が有効" do
      expect(user.valid?).to eq(true)
    end
    context "nameカラム" do
      it "Not null制限" do
        user = FactoryBot.build(:user, name: nil)
        expect(user.valid?).to eq(false)
      end
      it "空でないこと" do
        user = FactoryBot.build(:user, name: " ")
        expect(user.valid?).to eq(false)
      end
      it "30文字以内であること" do
        user = FactoryBot.build(:user, name: Faker::Lorem.characters(number: 31))
        expect(user.valid?).to eq(false)
      end
    end
    context "emailカラム" do
      it "Not null制限" do
        user = FactoryBot.build(:user, email: nil)
        expect(user.valid?).to eq(false)
      end
      it "メールアドレスの形式になっていること" do
        user = FactoryBot.build(:user, email: Faker::Lorem.characters(number: 10))
        expect(user.valid?).to eq(false)
      end
      it "メールドレスが一意であること" do
        FactoryBot.create(:user, email: "validate@email")
        user_2 = FactoryBot.build(:user, email: "validate@email")
        expect(user_2.valid?).to eq(false)
      end
    end
    context "パスワードカラム" do
      it "Not null制限" do
        user = FactoryBot.build(:user, password: nil)
        expect(user.valid?).to eq(false)
      end
      it "6文字以上であること" do
        user = FactoryBot.build(:user, password: Faker::Lorem.characters(number: 5))
        expect(user.valid?).to eq(false)
      end
    end
  end

  describe "アソシエーションテスト" do
    context "Topicモデルとの関係" do
      it "1:N関係" do
        expect(User.reflect_on_association(:topics).macro).to eq :has_many
      end
      it "Userの削除に伴う削除が有効" do
        FactoryBot.create(:topic, user: user)
        expect { user.destroy }.to change(Topic, :count).by(-1)
      end
    end
    context "Acquaintanceモデルとの関係" do
      it "1:N関係" do
        expect(User.reflect_on_association(:acquaintances).macro).to eq :has_many
      end
      it "Userの削除に伴う削除が有効" do
        FactoryBot.create(:acquaintance, user: user)
        expect { user.destroy }.to change(Acquaintance, :count).by(-1)
      end
    end
    context "Stockモデルとの関係" do
      it "1:N関係" do
        expect(User.reflect_on_association(:stocks).macro).to eq :has_many
      end
      it "Userの削除に伴う削除が有効" do
        FactoryBot.create(:stock, user: user, topic: topic, acquaintance: acquaintance)
        expect { user.destroy }.to change(Stock, :count).by(-1)
      end
    end
    context "Eventsモデルとの関係" do
      it "1:N関係" do
        expect(User.reflect_on_association(:events).macro).to eq :has_many
      end
      it "Userの削除に伴う削除が有効" do
        FactoryBot.create(:event, user: user)
        expect { user.destroy }.to change(Event, :count).by(-1)
      end
    end
    context "Commentモデルとの関係" do
      it "1:N関係" do
        expect(User.reflect_on_association(:comments).macro).to eq :has_many
      end
      it "Userの削除に伴う削除が有効" do
        FactoryBot.create(:comment, user: user, topic: topic)
        expect { user.destroy }.to change(Comment, :count).by(-1)
      end
    end
  end
end
