require "rails_helper"

RSpec.describe User, type: :system do
  describe "User CRUD" do
    let(:user) { create(:user) }

    describe "ログイン前" do
      describe "ユーザー新規登録" do
        context "成功" do
          it "作成完了" do
            visit new_user_registration_path
            fill_in "アカウント名", with: "test_sign_upuser"
            fill_in "メールアドレス", with: "test_sign_up@example.com"
            fill_in "パスワード（6桁以上）", with: "password"
            fill_in "確認用パスワード", with: "password"
            attach_file "プロフィール画像", "spec/fixtures/images/no_image.jpeg"
            click_button "登録する"
            expect(current_path).to eq topics_path
            expect(page).to have_link "ログアウト", href: destroy_user_session_path
          end
        end

        context "失敗" do
          it "作成失敗" do
            visit new_user_registration_path
            fill_in "アカウント名", with: " "
            fill_in "メールアドレス", with: " "
            fill_in "パスワード（6桁以上）", with: " "
            fill_in "確認用パスワード", with: " "
            click_button "登録する"
            expect(current_path).to eq users_path
            visit current_path
            expect(current_path).to eq new_user_registration_path
          end
        end
      end

      describe "ユーザーログイン" do
        context "成功" do
          it "ログイン完了" do
            visit new_user_session_path
            fill_in "メールアドレス", with: user.email
            fill_in "パスワード", with: user.password
            click_button "ログイン"
            expect(current_path).to eq topics_path
            expect(page).to have_content "ログアウト"
          end
        end
        context "失敗" do
          it "ログイン失敗" do
            visit new_user_session_path
            fill_in "メールアドレス", with: " "
            fill_in "パスワード", with: " "
            click_button "ログイン"
            expect(current_path).to eq new_user_session_path
          end
        end
      end

      describe "ゲストログイン" do
        context "成功" do
          it "ログイン完了" do
            visit root_path
            find("#guest_login").click
            expect(current_path).to eq topics_path
            expect(page).to have_content "ログアウト"
          end
        end
      end
    end

    describe "ログイン後" do
      before do
        visit new_user_session_path
        fill_in "メールアドレス", with: user.email
        fill_in "パスワード", with: user.password
        click_button "ログイン"
      end

      describe "ヘッダーアイコン" do
        before do
          visit user_path(user)
        end

        context "アイコンをクリック" do
          it "みんなのトピックに遷移" do
            find("#header_logo").click
            expect(current_path).to eq topics_path
          end
        end
      end

      describe "ユーザー編集" do
        context "正常" do
          it "編集完了" do
            visit user_path(user)
            expect(page).to have_content user.name
            find(".user_edit_modal").click
            fill_in "アカウント名", with: "user1"
            click_button "更新"
            expect(page).to have_content "user1"
          end
        end
      end

      describe "ログアウト" do
        context "正常" do
          it "トップページに遷移" do
            find("#log_out").click
            expect(current_path).to eq root_path
          end
        end
      end

      describe "退会" do
        before do
          visit confirm_user_path(user)
        end

        context "表示確認" do
          it "退会ボタンが表示されているか" do
            expect(page).to have_link "退会する", href: withdrawal_user_path(user)
            expect(page).to have_link "退会しない", href: user_path(user)
          end
        end
        context "退会する" do
          it "ボタンをクリックして退会する" do
            click_link "退会する"
            expect(user.reload.is_deleted).to eq true
            expect(current_path).to eq root_path
          end
        end
        context "退会しない" do
          it "退会せずにユーザープロフィール画面に戻る" do
            click_link "退会しない"
            expect(current_path).to eq user_path(user)
          end
        end
      end
    end
  end

  describe "フッターチェック" do
    context "正常に表示できるか" do
      before do
        visit root_path
      end
      it "利用規約" do
        find(".terms_of_use").click
        expect(page).to have_content "第1条（適用）"
      end
      it "プライバシーポリシー" do
        find(".user_policy").click
        expect(page).to have_content "第1条（個人情報）"
      end
    end
  end
end
