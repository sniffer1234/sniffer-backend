class Api::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :require_no_authentication

  def create
    self.resource = warden.authenticate!(auth_options.merge({ store: false }))

    # Prevent to login with account is blocked
    unless self.resource.active
      return render :json => { :error => { :code => 422, :description =>  "Conta bloqueada" } }, :status => 422
    end

    sign_in(resource_name, resource, store: false)
    render json: resource, root: 'data'
  end

end
