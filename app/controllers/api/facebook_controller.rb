class Api::FacebookController < ApplicationController

  def create
    @current_user = User.find_for_oauth({
      provider: 'facebook',
      uid: params[:uid],
      name: params[:name],
      email: params[:email]
    })

    if @current_user.sign_in_count == 0
      UserRegistrationMailer.welcome(@current_user).deliver_now
    end

    sign_in(:user, @current_user, store: false)
    @current_user.after_database_authentication

    render json: @current_user, root: 'data'
  end
end
