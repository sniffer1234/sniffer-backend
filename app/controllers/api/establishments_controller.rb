class Api::EstablishmentsController < Api::BaseController

  # GET /api/establishments
  def index
    @establishments = Establishment
                        .by_name(params[:search])
                        .by_tags(params[:tags])
                        .where(aprooved: true, visible: true)
                        .order(:name)
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
    @events = Event
                .by_establishment(params[:id])
                .page(params[:page] || 1)

    render json: @events, root: 'data', meta: pagination_dict(@events)
  end

  # POST /api/establishments
  def create
    @establishment = Establishment.new(establishment_params)

    unless @establishment.save(validate: false)
      return render :json => { :error => { :code => 422, :description =>  @establishment.errors.full_messages } }, :status => 422
    end
  end

  # GET api/establishments/sniffs
  def sniffs
    @establishments = Establishment
                        .sniffs_from_last_12_hours
                        .page(params[:page] || 1)

    render json: @establishments, each_serializer: EstablishmentSniffSerializer, root: 'data', meta: pagination_dict(@establishments)
  end

  private
  def establishment_params
    params.require(:establishment)
          .permit(:name, :phone, :suggestion_message)
          .merge(user_id: @current_user.id, visible: false, aprooved: false)
  end

end
