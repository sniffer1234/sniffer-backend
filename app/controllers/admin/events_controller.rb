class Admin::EventsController < Admin::BaseController
  before_action :set_event, only: [:destroy, :edit, :update]

  # GET /admin/events
  def index
    @events = Event.order(:name).page(params[:page] || 1)
  end

  # GET /admin/events/new
  def new
    @event = Event.new
    @event.build_address
  end

  # POST /admin/events
  def create
    @event = Event.new(establishment_params)

    if @event.save
      redirect_to admin_establishments_path, notice: 'Evento criado com sucesso.'
    else
      render :new
    end
  end

  # PUT /admin/events/:id
  def update
    if @event.update_attributes(establishment_params)
      redirect_to admin_establishments_path, notice: 'Evento editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /admin/events/:id
  def destroy
    if @event.destroy
      redirect_to admin_establishments_path, notice: 'Evento removido com sucesso.'
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :description
    )
  end
end
