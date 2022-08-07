require "rails_helper"

RSpec.describe "Word_search", type: :system do
  let(:user) { create(:user) }
  let!(:topic) { create(:topic, user: user) }
  let!(:other_topic) { create(:topic, user: user) }

  before do
    visit new_user_session_path
    fill_in "メールアドレス", with: user.email
    fill_in "パスワード", with: user.password
    click_button "ログイン"
  end

  describe "検索して表示するテスト" do
    context "トピックタイトルだけで検索" do
      it "該当あり" do
        find(".word_search_topic").set(topic.title)
        find(".word_search_button").click
        expect(page).to have_content topic.title
        expect(page).to_not have_content other_topic.title
        expect(page).to have_link topic.tags.first.name
      end
      it "該当なし" do
        find(".word_search_topic").set(Faker::Lorem.characters(number: 10))
        find(".word_search_button").click
        expect(page).to_not have_content topic.title
        expect(page).to_not have_content other_topic.title
      end
    end
    context "トピックの中身だけで検索" do
       it "該当あり" do
         find(".word_search_topic").set(topic.content)
         find(".word_search_button").click
         expect(page).to have_content topic.content
         expect(page).to_not have_content other_topic.content
       end
       it "該当なし" do
         find(".word_search_topic").set(Faker::Lorem.paragraph)
         find(".word_search_button").click
         expect(page).to_not have_content topic.content
         expect(page).to_not have_content other_topic.content
       end
     end
    context "タグだけで検索" do
      it "該当あり" do
        find(".word_search_tag").set(topic.tags.first.name)
        find(".word_search_button").click
        expect(page).to have_link topic.tags.first.name
        expect(page).to_not have_link other_topic.tags.first.name
      end
      it "該当なし" do
        find(".word_search_tag").set(Faker::Lorem.sentence(word_count: 2))
        find(".word_search_button").click
        expect(page).to_not have_link topic.tags.first.name
        expect(page).to_not have_link other_topic.tags.first.name
      end
    end
    context "トピックタイトル＆タグ両方で検索" do
      it "該当あり" do
        find(".word_search_topic").set(topic.title)
        find(".word_search_tag").set(topic.tags.first.name)
        find(".word_search_button").click
        expect(page).to have_content topic.title
        expect(page).to_not have_content other_topic.title
        expect(page).to have_link topic.tags.first.name
      end
      it "該当なし" do
        find(".word_search_topic").set(Faker::Lorem.characters(number: 10))
        find(".word_search_tag").set(Faker::Lorem.sentence(word_count: 2))
        find(".word_search_button").click
        expect(page).to_not have_content topic.title
        expect(page).to_not have_content other_topic.title
        expect(page).to_not have_link topic.tags.first.name
      end
    end
    context "トピックの中身＆タグ両方で検索" do
      it "該当あり" do
        find(".word_search_topic").set(topic.content)
        find(".word_search_tag").set(topic.tags.first.name)
        find(".word_search_button").click
        expect(page).to have_content topic.content
        expect(page).to_not have_content other_topic.content
        expect(page).to have_link topic.tags.first.name
      end
      it "該当なし" do
        find(".word_search_topic").set(Faker::Lorem.paragraph)
        find(".word_search_tag").set(Faker::Lorem.sentence(word_count: 2))
        find(".word_search_button").click
        expect(page).to_not have_content topic.content
        expect(page).to_not have_content other_topic.content
        expect(page).to_not have_link topic.tags.first.name
      end
    end
    context "どちらにも入力せずに検索" do
      it "全てのトピックが表示" do
        find(".word_search_topic").set(" ")
        find(".word_search_tag").set(" ")
        find(".word_search_button").click
        expect(page).to have_content topic.content
        expect(page).to have_content other_topic.content
        expect(page).to have_link topic.tags.first.name
      end
    end
  end
end
