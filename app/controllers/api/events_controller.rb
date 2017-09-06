class Api::EventsController < Api::BaseController

  # GET /api/events
  def index
    events_calendar = []
    events_by_date = Event.by_name(params[:search]).by_tags(params[:tags]).group_by_date

    events_by_date.each do |date, event|
      event_item = EventCalendar.new(when: date)
      event_item.events.push(event)
      events_calendar.push(event_item)
    end

    render json: events_calendar, root: 'data'
  end

  # GET /api/events/:id
  def show
    @event = Event.find(params[:id])
    render json: @event, root: 'data'
  end

  # POST /api/events
  def create
    @event = Event.new(event_params)

    unless @event.save(validate: false)
      return render :json => { :error => { :code => 422, :description =>  @event.errors.full_messages } }, :status => 422
    end
  end

  private
  def event_params
    params.require(:event)
          .permit(:name, :phone, :suggestion_message)
          .merge(user_id: @current_user.id, visible: false, aprooved: false)
  end
end
