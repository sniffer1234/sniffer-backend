class Admin::ImgsController < Admin::BaseController

  before_action :set_img, only: [:update, :destroy]

  # DELETE /admin/establishments/:establishment_id/:establishment_id/imgs/:id
  def destroy
    if @img.destroy
      redirect_to [:edit, :admin, @establishment, show_img_tab: true], notice: 'Estabelecimento criado com sucesso.'
    end
  end

  # PATCH /admin/establishments/:establishment_id/:establishment_id/imgs/:id
  def update
    if @img.update(img_params)
      redirect_to [:edit, :admin, @establishment, show_img_tab: true], notice: 'Estabelecimento editado com sucesso.'
    else
      render :edit
    end
  end

  # PUT /admin/imgs/sort
  def sort
    params[:imgs].each do |key,value|
      Img.find(value[:id]).update_attribute(:position, value[:position])
    end

    render :nothing => true
  end

  private

  def set_img
    @establishment = Establishment.find(params[:establishment_id])
    @img = @establishment.imgs.find(params[:id])
  end

  def img_params
    params.require(:img).permit(
      :src, :position
    )
  end
end
