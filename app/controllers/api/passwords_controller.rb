class Api::PasswordsController < Devise::PasswordsController

  # POST /resource/password/new
  def create
    @user = User.where.not(confirmed_at: nil).find_by(:email => resource_params[:email])

    if @user.nil?
      return render :json => { :error => { :code => 422, :description =>  "Email não encontrado ou não confirmado" } }, :status => 422
    end

    @user.send_reset_password_instructions

    unless successfully_sent?(@user)
      retunr render json: { error: { :code => 422, :description =>  @user.errors.full_messages } }, :status => 422
    end

    render json: {}
  end

  # PUT /resource/password
  def update
    self.resource = resource_class.reset_password_by_token(resource_params)
    yield resource if block_given?

    # Se não houver erros
    if resource.errors.empty?

      # Libera o acesso se tiver travado
      resource.unlock_access! if unlockable?(resource)

    else
      return render json: { :error => { :code => 422, :description =>  resource.errors.full_messages } }, :status => 422
    end

    render json: {}
  end
end
