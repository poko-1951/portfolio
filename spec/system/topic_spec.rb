require 'rails_helper'

RSpec.describe Topic, type: :system do

  describe "Topic" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let(:other_user) { create(:user) }
    let!(:other_topic) { create(:topic, user: other_user) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

    describe "トピック投稿のテスト" do
      it "トピック投稿" do
        visit tags_path
        find(".topic_post").click
        fill_in "タイトル", with: Faker::Lorem.characters(number: 10)
        fill_in "内容", with: Faker::Lorem.paragraph
        fill_in "タグ(半角スペースで複数個登録できます)", with: Faker::Lorem.sentence
        expect { click_button '登録' }.to change(Topic, :count).by(1)
        expect(current_path).to eq topics_path
      end
    end

    describe "トピック一覧画面のテスト" do
      before do
        find(".topics").click
      end

      context "トピック表示確認" do
        it "URLが正しい" do
          expect(current_path).to eq topics_path
        end
        it "投稿が表示されている" do
          expect(page).to have_content topic.title
          expect(page).to have_content other_topic.title
          expect(page).to have_link topic.tags.find(1).name
          expect(page).to have_link other_topic.tags.find(2).name
        end
        it "詳細画面へのリンクが正しい" do
          find('a', text: topic.title).click
          expect(page).to have_link topic.content
          expect(page).to have_link other_topic.content
        end
      end
    end

    describe "トピック詳細画面のテスト" do
      before do
        visit topic_path(topic)
      end

      context "表示確認" do
        it "タイトルと内容が表示されている" do
          expect(page).to have_content topic.title
          expect(page).to have_content topic.content
        end
        it "編集ボタンと削除ボタンが表示されている" do
          expect(page).to have_css ".fa-pen-to-square"
          expect(page).to have_css ".fa-trash-can"
        end
        it "コメント、ストック、お気に入りボタンが表示されている" do
          expect(page).to have_button "コメント" # コメント
          expect(page).to have_button "ストック" # ストック
          expect(page).to have_link "♡" # お気に入り
        end
        it "パンくずリストのリンクが正しい" do
          expect(page).to have_link "みんなのトピック"
        end
        it "他ユーザのトピックの場合には編集ボタンと削除ボタンが表示されていない" do
          visit topic_path(other_topic)
          expect(page).to_not have_css ".fa-pen-to-square"
          expect(page).to_not have_css ".fa-trash-can"
        end
      end
      context "編集" do
        before do
          find(".fa-pen-to-square").click
        end
        it "成功" do
          find(".edit_topic_title").set("edit_topic_title")
          find(".edit_topic_button").click
          expect(page).to have_content "edit_topic_title"
        end
        it "失敗" do
          find(".edit_topic_title").set(" ")
          find(".edit_topic_button").click
          expect(page).to have_content topic.title
        end
      end
      context "削除", js: true do
        it "成功" do
          find(".fa-trash-can").click
          expect {
            page.accept_confirm
            expect(current_path).to eq topics_path # 先に記述することでパスできる
          }.to change(Topic.all, :count).by(-1)
        end
      end
    end
  end
end