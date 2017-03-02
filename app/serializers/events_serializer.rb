
class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description
             :starts_at, :ends_at, :start_time,
             :end_time, :cover, :when, :establishment_name

  def start_time
    I18n.l(object.starts_at, format: :time)
  end

  def end_time
    I18n.l(object.ends_at, format: :time)
  end

  def starts_at
    I18n.l(object.starts_at, format: :abbreviated)
  end

  def ends_at
    I18n.l(object.ends_at, format: :abbreviated)
  end

end
