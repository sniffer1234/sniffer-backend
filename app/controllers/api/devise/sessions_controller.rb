class Api::Devise::SessionsController < Devise::SessionsController
  respond_to :json

  skip_before_filter :require_no_authentication

  def create
    self.resource = warden.authenticate!(auth_options)

    sign_in(resource_name, resource)
    render json: resource, root: 'data'
  end

  private
  def authenticate_account!(opts={})
    opts[:scope] = :account
    warden.authenticate!(opts) 
  end

end
