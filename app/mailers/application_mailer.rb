class ApplicationMailer < ActionMailer::Base
  default from: "admin@email.com"
  layout "mailer"
end
