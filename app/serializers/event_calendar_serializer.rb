class EventCalendarSerializer < ActiveModel::Serializer
  attributes :when, :day, :month_name, :week_day_name
  has_many :events, serializer: EventSerializer

  def when
    I18n.l(object.when, format: :only_dates)
  end
end
