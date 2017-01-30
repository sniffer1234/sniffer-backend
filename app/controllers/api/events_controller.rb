class Api::EventsController < Api::BaseController

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
end
