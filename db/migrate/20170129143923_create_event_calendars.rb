class CreateEventCalendars < ActiveRecord::Migration[5.0]
  def change
    create_table :event_calendars do |t|
      t.datetime :when

      t.timestamps
    end
  end
end
