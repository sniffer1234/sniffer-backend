class Api::MeController < Api::BaseController

  # PUT /api/me
  def update
    @current_user.settings(:notifications).email = user_params[:email_notification]
    @current_user.settings(:notifications).push = user_params[:push_notification]

    unless @current_user.update_attributes(user_params)
      return render :json => { :error => { :description => @current_user.errors.full_messages, :code => 422 }} , :status => 422
    end

    render json: @current_user, root: 'data'
  end

  # PUT /api/me/password
  def update_password
    unless @current_user.update_attributes(user_params)
      return render :json => { :error => { :description => @current_user.errors.full_messages, :code => 422 }} , :status => 422
    end

    render json: @current_user, root: 'data'
  end

  protected
  def user_params
    params.require(:user)
      .permit(
        :name, :phone, :cellphone, :avatar_url,
        :avatar, :password, :password_confirmation,
        :email_notification, :push_notification
      )
  end
end
