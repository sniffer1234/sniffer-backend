class Api::SessionsController < Devise::SessionsController
  respond_to :json
  skip_before_action :require_no_authentication

  def create
    self.resource = warden.authenticate!(auth_options.merge({ store:false }))

    sign_in(resource_name, resource, store: false)
    render json: resource, root: 'data'
  end

end
