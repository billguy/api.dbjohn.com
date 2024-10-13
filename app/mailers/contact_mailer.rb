class ContactMailer < ActionMailer::Base

  def new_contact(contact)
    @contact = contact
    mail(to: ENV['admin_email'], reply_to: "#{@contact.name} <#{@contact.email}>", subject: 'DBJohn.com contact form submission')
  end
end
