class Admin::EstablishmentEventsController < Admin::BaseController
  before_action :set_establishment
  before_action :set_event, only: [:destroy, :edit, :update]

  # GET /admin/establishemnts/:establishment_id/events
  def index
    order_by_attrs = ['vip', 'name', 'aprooved', 'active']
    order_by_asc = ['asc', 'desc']
    order_by = ""

    if params[:order_by_attr]
       if order_by_attrs.include?(params[:order_by_attr])
         order_by += params[:order_by_attr]
       end
    end

    if params[:order_by_asc] && !order_by.blank?
       if order_by_asc.include?(params[:order_by_asc])
         order_by += " #{ params[:order_by_asc] }"
       end
    end

    if order_by.blank?
      order_by = "name"
    end

    @events = Event
                .by_establishment(@establishment)
                .by_name(params[:search])
                .order(order_by)
                .page(params[:page] || 1)
  end

  # GET /admin/establishemnts/:establishment_id/events/new
  def new
    @event = Event.new
    @event.build_establishment
  end

  # POST /admin/establishemnts/:establishment_id/events
  def create
    @event = @establishment.events.build(event_params)

    if @event.save
      redirect_to admin_establishment_establishment_events_path, notice: 'Evento criado com sucesso.'
    else
      render :new
    end
  end

  # PUT /admin/establishemnts/:establishment_id/events/:id
  def update
    if @event.update_attributes(event_params)
      redirect_to admin_establishment_establishment_events_path, notice: 'Evento editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /admin/establishemnts/:establishment_id/events/:id
  def destroy
    if @event.destroy
      redirect_to admin_establishment_establishment_events_path, notice: 'Evento removido com sucesso.'
    end
  end

  private
  def set_establishment
    @establishment = Establishment.find(params[:establishment_id])
  end

  def set_event
    @event = @establishment.events.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :description, :when,
      :images, :vip, :aprooved, :cover,
      :visible, :starts_at, :ends_at, :no_time_to_end
    ).merge(user_id: @current_user.id)
  end
end
