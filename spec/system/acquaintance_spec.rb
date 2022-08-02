require 'rails_helper'

RSpec.describe Acquaintance, type: :system do
  describe "Acquaintance" do
    let(:user) { create(:user) }
    # let!(:topic) { create(:topic, user: user) }
    let!(:acquaintance) { create(:acquaintance, user: user) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      find(".sidebar_acquaintances").click
    end

    describe "お知り合い登録のテスト" do
      it "トピック投稿" do
        find(".acquaintance_post").click
        fill_in "お名前", with: Faker::Name.name
        expect { find(".acquaintance_post_register").click }.to change(Acquaintance, :count).by(1)
        expect(current_path).to eq acquaintances_path
      end
    end

    describe "お知り合い一覧のテスト" do
      context "トピック表示確認" do
        it "URLが正しい" do
          expect(current_path).to eq acquaintances_path
        end
        it "投稿が表示されている" do
          expect(page).to have_content acquaintance.name
          expect(page).to have_content acquaintance.like
        end
        it "詳細画面へのリンクが正しい" do
          expect(page).to have_link acquaintance.name
          expect(page).to have_link acquaintance.like
          click_link acquaintance.name
          expect(current_path).to eq acquaintance_path(acquaintance)
        end
      end
    end

    describe "お知り合い詳細のテスト" do
      
    end
  end
end