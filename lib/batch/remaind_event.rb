class Batch::RemaindEvent
  def self.remaind_event
    # Event.reload
    events = Event.all
    events.each do |event|
      time_difference = (event.start_at - Time.now.in_time_zone("Tokyo")) / 3600 # 時間に変換
      if time_difference <= 39 && time_difference >= 15
        RemaindEventMailer.creation_email(event).deliver_now
        p "メールを#{event.user.name}に送信しました"
      end
    end
  end
end
