class Api::ConfirmationsController < Devise::ConfirmationsController

# GET /resource/confirmation?confirmation_token=abcdef
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    # Necessário para gerar um authentication token
    resource.after_database_authentication

    unless resource.errors.empty?
      return render :json => { :error => { :code => 422, :description =>  resource.errors.full_messages } }, :status => 422
    end

    render json: @user, root: 'data'
  end

  # POST /resource/confirmation
  def create
    self.resource = User.find_by(email: resource_params[:email])

    if self.resource.nil?
      return render :json => { :error => { :code => 422, :description => "Email não encontrado ou já confirmado" } }, :status => 422
    end

    self.resource = self.resource.send_confirmation_instructions
    yield resource if block_given?

    unless successfully_sent?(resource)
      return render json: { :error => { :code => 422, :description =>  resource.errors.full_messages } }, :status => 422
    end

    render json: {}
  end

end
