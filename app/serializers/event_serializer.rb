class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :starts_at, :ends_at, :no_time_to_end

  def starts_at
    I18n.l(object.starts_at, format: :default)
  end

  def ends_at
    I18n.l(object.starts_at, format: :default)
  end
end
