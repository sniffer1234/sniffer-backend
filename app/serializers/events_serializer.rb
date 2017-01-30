class EventsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,
             :starts_at, :ends_at, :no_time_to_end,
             :start_time, :establishment_name, :cover

  def start_time
    I18n.l(object.starts_at, format: :time)
  end

  def starts_at
    I18n.l(object.starts_at, format: :abbreviated)
  end

  def ends_at
    I18n.l(object.starts_at, format: :abbreviated)
  end

end
