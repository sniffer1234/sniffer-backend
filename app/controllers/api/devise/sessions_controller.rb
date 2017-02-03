class Api::Devise::SessionsController < Devise::SessionsController
  respond_to :json, :html
  def create
    puts '=== - '
    puts '=== - '

    self.resource = warden.authenticate!(auth_options)
    puts '=== 1 '
    sign_in(resource_name, resource)
    puts '=== 2'

    yield resource if block_given?
    puts '=== 3 '

    render json: resource, root: 'data'
 end

end
