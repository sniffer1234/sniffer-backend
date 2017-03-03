class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :small_description,
             :description, :email, :phone,
             :site, :facebook, :instagram,
             :vip, :cover, :avatar, :address,
             :small_business_hours_description, :business_hours_description

  has_one :tags, serializer: TagSerializer

  def address
    object.address.completed
  end
end
