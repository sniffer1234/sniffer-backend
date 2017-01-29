class EventSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :when, :from, :to

  def when
    I18n.l(object.when, format: :registred_at)
  end
end
