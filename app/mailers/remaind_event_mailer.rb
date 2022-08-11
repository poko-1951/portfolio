class RemaindEventMailer < ApplicationMailer
  def creation_email(event)
    @event = event
    mail(
      subject: "【Converce】イベントリマインダー",
      to: event.user.email,
    )
  end
end
