class SuggestionMailer < ApplicationMailer

  def notify(suggestion)
    @suggestion = suggestion
    @user = @suggestion.user

    mail(to: "sniffercontato@gmail.com",
         reply_to: @user.email,
         subject: "Sniffer: Nova sugestão recebida")
  end
end
