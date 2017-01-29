class Admin::ImgsController < Admin::BaseController

  before_action :set_img, only: [:update, :destroy]

  # DELETE /admin/:resource/:resource_id/imgs/:id
  def destroy
    if @img.destroy
      redirect_to [:edit, :admin, @resource, show_img_tab: true], notice: 'Imagem removida com sucesso.'
    end
  end

  # PATCH /admin/:resource/:resource_id/imgs/:id
  def update
    if @img.update(img_params)
      redirect_to [:edit, :admin, @resource, show_img_tab: true], notice: 'Imagem editada com sucesso.'
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
    @img = Img.find(params[:id])
    @resource = @img.imageable_type.constantize.find(@img.imageable_id)
  end

  def img_params
    params.require(:img).permit(
      :src, :position
    )
  end
end
