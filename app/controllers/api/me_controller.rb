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

  # GET /api/me/sniffs
  def sniffs
    @establishments = Establishment.sniffs_by_user_from_last_12_hours(@current_user.id).page(1).per(5)
    render json: @establishments, each_serializer: EstablishmentSniffSerializer, root: 'data', meta: pagination_dict(@establishments)
  end

  # POST /api/me/sniff
  def create_sniff
    @sniff = @current_user.sniffs.build(sniff_params)

    unless @sniff.save
      return render :json => { :error => { :description => @current_user.errors.full_messages, :code => 422 }} , :status => 422
    end

    render json: @sniff, root: 'data'
  end

  protected
  def user_params
    params.require(:user)
      .permit(
        :name, :phone, :cellphone, :avatar_data,
        :avatar, :password, :password_confirmation,
        :email_notification, :push_notification
      )
  end

  def sniff_params
    params.require(:sniff)
      .permit(
        :src, :duration,:sniffable_id, :sniffable_type,
        :img_data, :video_data
      )
  end
end
