class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAIL_SMTP_LOGIN']
  layout 'mailer'
end
