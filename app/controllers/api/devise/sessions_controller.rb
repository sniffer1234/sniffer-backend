class Api::Devise::SessionsController < Devise::SessionsController
  respond_to :json, :html

  def create
    puts '--- 1'
    self.resource = warden.authenticate!(auth_options)
    puts '--- 2'

    sign_in(resource_name, resource)
    puts '--- 3'


    yield resource if block_given?
    puts '--- 4'

    render json: resource, root: 'data'
 end

end
