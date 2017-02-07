class Api::SessionsController < Devise::SessionsController
  respond_to :json
  #before_action :renew_session
  skip_before_action :require_no_authentication

  def create

    self.resource = warden.authenticate!(auth_options.merge({ store:false }))

    sign_in(resource_name, resource, store: false)
    render json: resource, root: 'data'
  end

  # private
  # def renew_session
  #   reset_session
  # end
end
