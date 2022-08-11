class RemaindEventMailer < ApplicationMailer
  def creation_email(topic)
    @topic = topic
    mail(
      subject: "イベントリマインダー",
      to: "user@example.com",
      from: "task@example.com"
    )
  end
end
