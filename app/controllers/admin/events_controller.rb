class Admin::EventsController < Admin::BaseController
  before_action :set_event, except: [:index]

  # GET /admin/events
  def index
    order_by_attrs = ['vip', 'name', 'visible', 'starts_at']
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
      order_by = "starts_at ASC"
    end

    @events = Event.where(aprooved: true)
                   .order(order_by)
                   .page(params[:page] || 1)
  end

  # GET /admin/events/:id
  def edit
  end

  # PUT /admin/events/:id
  def update
    if @event.update_attributes(event_params)
      redirect_to admin_events_path, notice: 'Evento editado com sucesso.'
    else
      render :edit
    end
  end

  # DELETE /admin/events/:id
  def destroy
    if @event.destroy
      redirect_to admin_events_path, notice: 'Evento removido com sucesso.'
    end
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(
      :name, :description, :when,
      :images, :vip, :aprooved, :cover,
      :visible, :starts_at, :ends_at, :no_time_to_end
    ).merge(user_id: @current_user.id)
  end
end
