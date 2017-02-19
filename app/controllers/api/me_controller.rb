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

  # POST /api/me/sniff
  def create_sniff
    @sniff = @current_user.sniffs.build(sniff_params)

    unless @sniff.save
      return render :json => { :error => { :description => @current_user.errors.full_messages, :code => 422 }} , :status => 422
    else

      # Create active model serializers
      sniff = ActiveModelSerializers::SerializableResource.new(
        Establishment.with_sniffs.limit(1),
        each_serializer: EstablishmentSniffSerializer,
        root: 'data'
      ).as_json

      # Send push notification
      Pusher.trigger('live', 'new:sniff', sniff)
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
        :src, :duration, :src_data,
        :sniffable_id, :sniffable_type
      )
  end
end
