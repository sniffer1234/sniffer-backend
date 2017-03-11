class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description,
             :starts_at, :ends_at, :start_time,
             :end_time, :cover, :avatar, :when

  has_one :establishment, serializer: ShortEstablishmentSerializer

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
