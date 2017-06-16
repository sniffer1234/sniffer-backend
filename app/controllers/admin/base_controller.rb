class Admin::BaseController < ApplicationController
  layout 'application_admin'
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :get_current_user
  before_action :check_user_role!

  private

  # Create a alias to access user
  def get_current_user
    @current_user = current_user
  end

  # Verify if user is admin
  def check_user_role!
    if @current_user.default?
      redirect_to destroy_user_session_path and return
    end
  end

end
