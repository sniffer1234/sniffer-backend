class Admin::SniffsController < Admin::BaseController

  before_action :load_sniff, only: [:create, :destroy]

  # GET /admin/sniffs
  def index
    @sniffs = Sniff.all.order(id: :desc).page(params[:page] || 1)
  end

  # DELETE /admin/sniffs/:id
  def destroy
    if @sniff.destroy
      redirect_to admin_sniffs_path, notice: 'Sniff removido com sucesso.'
    end
  end

  # DELETE /admin/sniffs/destroy_multiple
  def destroy_multiple
    if Sniff.destroy(params[:sniffs])
      redirect_to admin_sniffs_path, notice: 'Sniffs removidos com sucesso.'
    end
  end

  private
  def load_sniff
    @sniff = Sniff.find(params[:id])
  end

end
