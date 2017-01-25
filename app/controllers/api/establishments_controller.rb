class Api::EstablishmentsController < Api::BaseController

  # GET /api/establishments
  def index
    @establishments = Establishment.page(params[:page] || 1).per(10)
    render json: @establishments, root: 'data', meta: pagination_dict(@establishments)
  end

end
