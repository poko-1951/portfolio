require 'rails_helper'

RSpec.describe Comment, type: :system do

  describe "Comment" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:comment) { create(:comment, user: user, topic: topic) }
    let(:other_user) { create(:user) }
    let!(:other_comment) { create(:comment, user: other_user, topic: topic) }


    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
      visit topic_path(topic)
    end

    describe "コメント投稿のテスト" do
      context "コメントを投稿する", js: true do
        before do
          find(".comment_post_modal").click
        end
        it "成功" do
          find(".comment_text_area").set(Faker::Lorem.paragraph)
          expect {
            find(".comment_post_button").click
            sleep(2)
            expect(current_path).to eq topic_path(topic)
          }.to change(Comment.all, :count).by(1)
        end
        it "失敗" do
          find(".comment_text_area").set(" ")
          expect {
            find(".comment_post_button").click
            expect(current_path).to eq topic_path(topic)
          }.to change(Comment.all, :count).by(0)
        end
      end
    end

    describe "コメント削除のテスト" do

    end
  end
end