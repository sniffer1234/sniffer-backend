class Api::EstablishmentsController < Api::BaseController

  # GET /api/establishments
  def index
    establishments = Establishment.all
    render json: establishments, root: 'data'
  end

  def show
  end
end
