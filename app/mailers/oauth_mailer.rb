class OauthMailer < ApplicationMailer

  def welcome(user)
    @user = user

    mail(to: @user.email,
         subject: "Sniffer: Seja bem-vindo(a)")
  end
end
