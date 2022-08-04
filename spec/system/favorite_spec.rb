require 'rails_helper'

RSpec.describe "Favorite", type: :system do
  let(:user) { create(:user) }
  let!(:topic) { create(:topic, user: user) }
  let!(:stock) { create(:stock, user: user, topic: topic, acquaintance: nil) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
    find(".sidebar_favorite").click
  end

  describe "お知り合い一覧のテスト" do
    context "表示確認" do
      it "URLが正しい" do
        expect(current_path).to eq favorite_topics_topics_path
      end
      it "お気に入りトピックが表示されている" do
        expect(page).to have_content topic.title
        expect(page).to have_link topic.tags.first.name
      end
    end

    context "画面遷移" do
      it "トピック詳細画面に遷移" do
        click_link topic.content
        expect(current_path).to eq topic_path(topic)
      end
      it "タグ検索結果画面に遷移" do
        find(".tag_name").click
        expect(current_path).to eq tag_search_topics_path
      end
      it "ユーザープロフィールに遷移" do
        find(".topic_user_name").click
        expect(current_path).to eq user_path(stock.user)
      end
    end
  end
end