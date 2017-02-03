class Api::Devise::RegistrationsController < Devise::RegistrationsController
  before_action :configure_devise_permitted_parameters

  def configure_devise_permitted_parameters
    registration_params = [:name, :email, :password, :password_confirmation]
    update_params = [:name, :cellphone, :password, :password_confirmation]

    if params[:action] == 'update'
      devise_parameter_sanitizer.permit(:account_update) {
        |u| u.permit(update_params)
      }
    elsif params[:action] == 'create'
      devise_parameter_sanitizer.permit(:sign_up) {
        |u| u.permit(registration_params)
      }
    end
  end

  # POST /resource
  def create
    build_resource(sign_up_params)

    resource.save
    yield resource if block_given?
    if resource.persisted?

      # Criado com sucesso, nao precisa de confirmação
      if resource.active_for_authentication?
        sign_up(resource_name, resource)
      else

        # Conta criada com sucesso, necessita fazer confirmação
        expire_data_after_sign_in!
      end
    else
      clean_up_passwords resource
      set_minimum_password_length

      return render :json => { :error => { :code => 422, :description =>  resource.errors.full_messages } }, :status => 422
    end

    return render json: {}
  end
end
