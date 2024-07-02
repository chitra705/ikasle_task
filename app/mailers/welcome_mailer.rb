class WelcomeMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.welcome_mailer.welcome_email.subject
  
  default from: 'rchitra737@gmail.com'
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to our App!')
  end
end
