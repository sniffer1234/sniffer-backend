class Api::Devise::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @current_user = User.find_for_oauth(env["omniauth.auth"], current_user)

        sign_in(:user, @current_user)
        @current_user.after_database_authentication

        render json: @current_user
      end
    }
  end

  [:facebook].each do |provider|
    provides_callback_for provider
  end
end
