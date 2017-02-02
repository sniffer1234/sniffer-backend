class Api::Devise::SessionsController < Devise::SessionsController
  respond_to :json, :html

  def new
    render json: {}
  end

  def create
    self.resource = warden.authenticate!(auth_options)
    sign_in(resource_name, resource)
    yield resource if block_given?
    render json: resource, root: 'data'
 end

end
