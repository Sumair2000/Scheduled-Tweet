class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    @token = params[:user].signed_id(purpose: "password_reset", expires_in: 15.minutes)

    mail to: params[:user].email, subject: "Reset Password"
  end

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Scheduled Tweet')
  end

  def registration_confirmation(user)
    @user = user
    mail(to: @user.email, subject:"Registration Confirmation")
  end

end
