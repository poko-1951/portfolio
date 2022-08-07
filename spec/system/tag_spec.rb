require 'rails_helper'

RSpec.describe Tag, type: :system do

  describe "Tag" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      find(".sidebar_tag").click
    end

    describe "トピックタグ一覧のテスト" do
      context "タグ表示確認" do
        it "URLが正しい" do
          expect(current_path).to eq tags_path
        end
        it "タグが表示されている" do
          expect(page).to have_link topic.tags.find(1).name
        end
      end
    end

    describe "タグ検索のテスト" do
      it "クリックして検索する" do
        click_link Tag.find(1).name
        expect(page).to have_content topic.title
      end
    end
  end
end