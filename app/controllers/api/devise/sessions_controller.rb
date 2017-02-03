class Api::Devise::SessionsController < Devise::SessionsController
  respond_to :json

  def create
    self.resource = warden.authenticate!(auth_options)

    sign_in(resource_name, resource)
    render json: resource, root: 'data'
 end

end
