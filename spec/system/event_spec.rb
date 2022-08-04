require 'rails_helper'

RSpec.describe Event, type: :system do
  describe "Event" do
    let(:user) { create(:user) }
    let!(:topic) { create(:topic, user: user) }
    let!(:acquaintance) { create(:acquaintance, user: user) }
    let!(:stock) { create(:stock, user: user, topic: topic, acquaintance: acquaintance) }
    let!(:event) { create(:event, user: user) }
    let!(:schedule) { create(:schedule, acquaintance: acquaintance, event: event) }

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
        visit events_path
      end

      context "表示確認" do
        it "URLが正しいか" do
          find(".sidebar_calendar").click
          expect(current_path).to eq events_path
        end
        it "イベントが表示されている", js: true do
          expect(page).to have_css ".fc-daygrid-event"
        end
        it "詳細画面へのリンクが正しい", js: true do
          first(".fc-daygrid-event").click
          expect(current_path).to eq event_path(event)
        end
      end
    end

    describe "イベント詳細のテスト" do
      before do
        visit event_path(event)
      end

      context "表示確認" do
        it "イベント詳細が表示されている" do
          expect(page).to have_content event.title
          expect(page).to have_content event.start_at.strftime('%Y/%m/%d %H:%M')
          expect(page).to have_content event.end_at.strftime('%Y/%m/%d %H:%M')
          expect(page).to have_content event.content
          expect(page).to have_content event.place
        end
        it "お相手が表示されている" do
          expect(page).to have_link acquaintance.name, href: acquaintance_path(acquaintance)
        end
        it "編集ボタンと削除ボタンが表示されている" do
          expect(page).to have_css ".fa-pen-to-square"
          expect(page).to have_css ".fa-trash-can"
        end
        it "パンくずリストのリンクが正しい" do
          expect(page).to have_link "カレンダー", href: events_path
        end
        it "カレンダーに戻るのリンクが正しい" do
          expect(page).to have_link "カレンダーに戻る", href: events_path
        end
      end
      context "編集" do
        before do
          find(".fa-pen-to-square").click
        end

        it "成功" do
          fill_in "予定", with: "event"
          find(".edit_event_button").click
          # expect {
          #   find(".edit_event_button").click
          #   event.reload
          # }.to change{ event }
          expect(page).to have_content "event"
          expect(current_path).to eq event_path(event)
        end
        it "失敗" do
          fill_in "予定", with: " "
          find(".edit_event_button").click
          expect(page).to_not have_content "event"
        end
      end
      context "削除", js: true do
        it "成功" do
          find(".fa-trash-can").click
          expect {
            page.accept_confirm
            sleep(2)
            expect(current_path).to eq events_path # 先に記述することでパスできる
          }.to change(Event.all, :count).by(-1)
        end
      end
    end
  end
end