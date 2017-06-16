class Admin::UsersController < Admin::BaseController

  before_action :set_users, only: [:edit, :update, :destroy]
  before_action :set_roles

  # GET /admin/users
  def index
    order_by_attrs = ['created_at', 'name', 'last_sign_in_at', 'active']
    order_by_asc = ['asc', 'desc']
    order_by = ""

    if params[:order_by_attr]
       if order_by_attrs.include?(params[:order_by_attr])
         order_by += params[:order_by_attr]
       end
    end

    if params[:order_by_asc] && !order_by.blank?
       if order_by_asc.include?(params[:order_by_asc])
         order_by += " #{ params[:order_by_asc] }"
       end
    end

    if order_by.blank?
      order_by = "name"
    end

    @users = User.by_name(params[:search])
                 .order(order_by)
                 .page(params[:page] || 1)
  end

  # GET /admin/users
  def new
    @user = User.new
  end

  # POST /admin/users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to admin_users_path, notice: 'Usuário criado com sucesso.'
    else
      render :new
    end
  end

  # GET /admin/users/:id
  def edit
  end

  # PATCH /admin/users/:id
  def update
    if @user.update_attributes(user_params)
      redirect_to admin_users_path, notice: 'Usuário editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /admin/users/:id
  def destroy
    @user.active = !@user.active

    if @user.save
      redirect_to admin_users_path, notice: 'Usuário editado com sucesso.'
    end
  end

  private
  def set_users
    @user = User.find(params[:id])
  end

  def set_roles
    @roles = ['default', 'admin', 'owner']
  end

  def user_params
    params.require(:user)
          .permit(:name, :cellphone, :email, :password, :password_confirmation, :avatar, :role)
  end

end
