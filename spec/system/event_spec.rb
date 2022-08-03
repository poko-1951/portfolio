require 'rails_helper'

RSpec.describe Event, type: :system do
  describe "Acquaintance" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:acquaintance) { create(:acquaintance, user: user) }
    let!(:stock) { create(:stock, user: user, topic: topic, acquaintance: acquaintance) }
    let!(:event) { create(:event, user: user, end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

    describe "カレンダー一覧のテスト" do
      before do
        find(".sidebar_calendar").click
      end

      context "表示確認" do
        it "URLが正しいか" do
          byebug
          expect(current_path).to eq events_path
        end
      end
    end
  end
end