class EventsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,
             :starts_at, :ends_at, :start_time,
             :end_time, :cover, :establishment_name,
             :ends_in_the_same_day, :ends_in_the_next_day

  def cover
   return {
     medium: object.cover.url(:medium),
     thumb: object.cover.url(:thumb),
     micro: object.cover.url(:micro)
   }
  end
  
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
