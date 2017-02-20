class Admin::EstablishmentsController < Admin::BaseController

  before_action :load_establishment, only: [:destroy, :edit, :update]

  # GET /admin/establishments
  def index
    order_by_attrs = ['vip', 'name', 'aprooved', 'active']
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

    @establishments = Establishment.by_name(params[:search]).order(order_by).page(params[:page] || 1)
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

  # GET admin/establishments/:id/edit
  def edit
    if @establishment.address.nil?
      @establishment.build_address
    end
  end

  # PUT /admin/establishments/:id
  def update
    if @establishment.update_attributes(establishment_params)
      redirect_to admin_establishments_url, notice: 'Estabelecimento editado com sucesso.'
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
      :facebook, :instagram, :phone, :email, :active, :visible,
      :vip, :aprooved, :phone, :cover, :avatar,
      address_attributes: [
        :id, :zipcode, :neighborhood, :street, :number, :complement, :city_id
      ]
    )
  end
end
