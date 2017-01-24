class Admin::BaseController < ApplicationController

  protect_from_forgery with: :exception
  layout 'application_logged'

  before_action :authenticate_user!
  before_action :get_current_user

  def get_current_user
    @current_user = current_user;
  end

  def after_sign_in_path_for(resource)
    admin_dashboard_index_path
  end
end
