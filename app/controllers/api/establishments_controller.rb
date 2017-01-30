class Api::EstablishmentsController < Api::BaseController

  # GET /api/establishments
  def index
    @establishments = Establishment.page(params[:page] || 1)
    render json: @establishments, root: 'data', meta: pagination_dict(@establishments)
  end

  # GET /api/establishments/:id/events
  def events
    @events = Event.all.where(establishment_id: params[:id]).page(params[:page] || 1)
    render json: @events, root: 'data', meta: pagination_dict(@events)
  end

end
