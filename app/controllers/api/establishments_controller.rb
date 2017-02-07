class Api::EstablishmentsController < Api::BaseController

  # GET /api/establishments
  def index
    @establishments = Establishment
                        .by_name(params[:search])
                        .by_tags(params[:tags])
                        .page(params[:page] || 1)

    render json: @establishments, root: 'data', meta: pagination_dict(@establishments)
  end

  # GET /api/establishments/:id
  def show
    @establishment = Establishment.find(params[:id])
    render json: @establishment, root: 'data'
  end

  # GET /api/establishments/:id/events
  def events
    @events = Event.by_establishment(params[:id]).page(params[:page] || 1)
    render json: @events, root: 'data', meta: pagination_dict(@events)
  end

  # POST /api/establishments
  def create
    # TODO - SET USER_ID
    @establishment = Establishment.new(establishment_params)

    # Necessary to filter
    @establishment.aprooved = false

    if @establishment.save(validate: false)
      render json: {}
    else
      render json: { errors: @establishment.errors.full_messages }
    end
  end

  private

  def establishment_params
    params.require(:establishment).permit(
      :name, :phone, :suggestion_message
    )
  end

end
