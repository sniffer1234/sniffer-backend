class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :small_description,
             :description, :email, :phone,
             :site, :facebook, :instagram,
             :vip, :cover, :avatar, :address,
             :small_business_hours_description,
             :business_hours_description

  has_one :tags, serializer: TagSerializer

  def address
    object.address.completed
  end

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
      medium: object.avatar.url(:medium),
      thumb: object.cover.url(:thumb),
      micro: object.avatar.url(:micro)
    }
  end
end
