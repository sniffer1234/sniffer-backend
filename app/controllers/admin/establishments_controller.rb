class Admin::EstablishmentsController < Admin::BaseController

  before_action :load_establishment, only: [:create, :destroy]

  # GET /admin/users
  def index
    @establishments = Establishment.order(:name).page(params[:page] || 1)
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
  def load_establishment
    @establishment = Establishment.find(params[:id])
  end

  def local_params
    params.require(:local).permit(
      :name, :description,:email, :site, :facebook,
      :instagram, :vip, :active, :phone, :imgs,
      address_attributes: [:id, :zipcode, :neighborhood, :street, :number, :complement, :city_id]
    )
  end
end
