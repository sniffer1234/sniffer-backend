class Admin::EstablishmentsController < Admin::BaseController

  before_action :load_establishment, only: [:destroy, :edit, :update]

  # GET /admin/establishments
  def index
    @establishments = Establishment.order(:name).page(params[:page] || 1)
  end

  # GET /admin/establishments/new
  def new
    @establishment = Establishment.new
    @establishment.build_address
  end

  # POST /admin/establishments
  def create
    @establishment = Establishment.new(establishment_params)

    if @establishment.save
      redirect_to admin_establishments_path, notice: 'Estabelecimento criado com sucesso.'
    else
      render :new
    end
  end

  # PUT /admin/establishments/:id
  def update
    if @establishment.update_attributes(establishment_params)
      redirect_to admin_establishments_path, notice: 'Estabelecimento editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /admin/establishments/:id
  def destroy
    if @establishment.destroy
      redirect_to admin_establishments_path, notice: 'Estabelecimento removido com sucesso.'
    end
  end

  private
  def load_establishment
    @establishment = Establishment.find(params[:id])
  end

  def establishment_params
    params.require(:establishment).permit(
      :name, :small_description, :description, :site,
      :facebook, :instagram, :phone, :email
    )
  end
end
