require 'rails_helper'

RSpec.describe User, type: :system do
  let!(:user) { create(:user) }

  describe "User CRUD" do
    describe "ログイン前" do
      describe "ユーザー新規登録" do
        context "正常" do
          it "作成完了" do
            visit new_user_registration_path
            fill_in "アカウント名", with: "test_user"
            fill_in "メールアドレス", with: "test1@example.com"
            fill_in "パスワード（6桁以上）", with: "password"
            fill_in "確認用パスワード", with: "password"
            click_button "登録する"
            expect(current_path).to eq topics_path
            expect(page).to have_content 'ログアウト'
            sign_out user
          end
        end
      end

      describe "ユーザーログイン" do
        context "正常" do
         it "ログイン完了" do
          visit new_user_session_path
          fill_in "メールアドレス", with: "test@example.com"
          fill_in "パスワード", with: "password"
          click_button "ログイン"
          expect(current_path).to eq topics_path
          expect(page).to have_content 'ログアウト'
          sign_out user
         end
        end
      end
    end

    describe "ログイン後" do
      describe "ユーザー編集" do
        context "正常" do
          it "編集完了" do
            visit new_user_session_path
            fill_in "メールアドレス", with: "test@example.com"
            fill_in "パスワード", with: "password"
            click_button "ログイン"
            visit user_path(user)
            expect(page).to have_content 'user'
            find('.user_edit_modal').click
            fill_in "アカウント名", with: "user1"
            click_button "更新"
            expect(page).to have_content 'user1'
            byebug
          end
        end
      end
    end
  end
end