class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :avatar

  def avatar
    {
      large: object.avatar.url(:large),
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
      original: object.avatar.url(:original)
    }
  end
end
