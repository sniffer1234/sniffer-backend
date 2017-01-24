class Admin::UsersController < Admin::BaseController

  before_action :load_user, only: [:create, :destroy]

  # GET /admin/users
  def index
    @users = User.order(:name).page(params[:page] || 1)
  end

  # POST /admin/users
  def create
  end

  # PUT /admin/users/:id
  def update
  end

  # DELETE /admin/users/:id
  def destroy
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

end
