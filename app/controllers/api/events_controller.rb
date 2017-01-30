class Api::EventsController < Api::BaseController

  # GET /api/events
  def index
    events_calendar = []
    events_by_date = Event.group_by_date

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
    render json: @event
  end

  # POST /api/events
  def create
    # TODO - SET USER_ID
    @event = event.new(event_params)

    # Necessary to filter
    @event.aprooved = false

    if @event.save(validate: false)
      render json: {}
    else
      render json: { errors: @event.errors.full_messages }
    end
  end

  private
  def event_params
    params.require(:event).permit(:name, :phone, :suggestion_message)
  end
end
