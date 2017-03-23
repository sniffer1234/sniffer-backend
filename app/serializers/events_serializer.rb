class EventsSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :small_description,
             :starts_at, :ends_at, :start_time,
             :end_time, :cover, :avatar, :establishment_name,
             :ends_in_the_same_day, :ends_in_the_next_day

  def cover
    return {
      large: object.cover.url(:large),
      medium: object.cover.url(:medium),
      thumb: object.cover.url(:thumb),
      micro: object.cover.url(:micro)
    }
  end

  def avatar
    return {
      large: object.avatar.url(:large),
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
      micro: object.avatar.url(:micro)
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
