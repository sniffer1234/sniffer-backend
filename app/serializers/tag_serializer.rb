class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :alias, :avatar

  def avatar
    return {
      large: object.avatar.url(:large),
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
      micro: object.avatar.url(:micro)
    }
  end
end
