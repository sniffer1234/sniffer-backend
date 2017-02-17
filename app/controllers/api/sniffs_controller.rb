class Api::SniffsController < Api::BaseController

  # GET /api/establishment/:id/sniffs
  def index
    @sniffs = Sniff.by_establishment(params[:establishment_id]).order(id: :desc).limit(10)
    render json: @sniffs, root: 'data'
  end
end
