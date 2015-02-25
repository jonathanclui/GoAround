class UserMailer < ApplicationMailer

  def account_activation(user)
    @user = user
    mail to: user.email, subject: "GoAround - Account activation"
  end

  def password_reset(user)
    @user = user
    mail to: user.email, subject: "GoAround - Password reset"
  end
end
