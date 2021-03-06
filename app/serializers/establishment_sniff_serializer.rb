class EstablishmentSniffSerializer < ActiveModel::Serializer
  attributes :id, :name, :cover, :avatar
  has_one :last_sniff, serializer: SniffSerializer

  def cover
    return {
      medium: object.cover.url(:medium),
      thumb: object.cover.url(:thumb),
      micro: object.cover.url(:micro)
    }
  end

  def avatar
    return {
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
      micro: object.avatar.url(:micro)
    }
  end
end
