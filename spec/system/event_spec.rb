require 'rails_helper'

RSpec.describe Event, type: :system do
  describe "Acquaintance" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:acquaintance) { create(:acquaintance, user: user) }
    let!(:stock) { create(:stock, user: user, topic: topic, acquaintance: acquaintance) }
    # let!(:event) { create(:event, user: user, end: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)) }

    before do
      visit new_user_session_path
      fill_in "メールアドレス", with: user.email
      fill_in "パスワード", with: user.password
      click_button "ログイン"
    end

    describe "イベント登録のテスト", js: true do
      let!(:time_count) { Time.now }
      before do
        visit events_path
      end
      it "イベント登録" do
        first(".fc-daygrid-day-frame").click
        fill_in "予定", with: "event"
        find( "#event_acquaintance_ids_#{ acquaintance.id }" ).click
        expect {
          find(".event_post_button").click
        }.to change(Event.all, :count).by(1) and change(Schedule.all, :count).by(1)
      end
    end

    describe "カレンダー一覧のテスト" do
      before do
        find(".sidebar_calendar").click
      end

      context "表示確認" do
        it "URLが正しいか" do
          expect(current_path).to eq events_path
        end
      end
    end
  end
end