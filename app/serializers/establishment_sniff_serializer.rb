include ActionView::Helpers::DateHelper

class EstablishmentSniffSerializer < ActiveModel::Serializer
  attributes :id, :name, :cover, :avatar, :last_sniff

  def last_sniff
    return {
      id: object.last_sniff.id,
      time_ago: "#{ time_ago_in_words(object.last_sniff.created_at) } atrás",
      user: {
        id: object.last_sniff.user.id,
        first_name: object.last_sniff.user.first_name,
        name: object.last_sniff.user.name
      }
    }
  end
end
