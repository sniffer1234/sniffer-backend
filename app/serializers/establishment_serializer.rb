class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :small_description,
             :description, :email, :phone,
            :site, :facebook, :instagram,
             :vip, :cover, :avatar, :address

  has_one :tags, serializer: TagSerializer

  def address
    object.address.completed
  end
end
