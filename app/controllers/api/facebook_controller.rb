class Api::FacebookController < ApplicationController

  def index
    @current_user = User.find_for_oauth({ provider: 'facebook', uid: params[:uid] })

    sign_in(:user, @current_user)
    @current_user.after_database_authentication

    render json: @current_user
  end
end
