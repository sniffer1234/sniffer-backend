class EventCalendar < ApplicationRecord
  has_many :events

  # Return day
  def day
    I18n.l(self.when, format: :day)
  end

  # Return month name
  def month_name
    I18n.l(self.when, format: :month_name)
  end

  # Return week day name
  def week_day_name
    I18n.l(self.when, format: :week_day_name)
  end
end
