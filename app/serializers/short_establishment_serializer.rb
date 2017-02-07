class ShortEstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :address

  def address
    object.address.completed
  end
end
