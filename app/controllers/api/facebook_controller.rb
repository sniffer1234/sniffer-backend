class Api::FacebookController < ApplicationController

  def create
    @current_user = User.find_for_oauth({
      provider: 'facebook',
      uid: params[:uid],
      name: params[:name],
      email: params[:email]
    })

    sign_in(:user, @current_user)
    @current_user.after_database_authentication

    render json: @current_user, root: 'data'
  end
end
