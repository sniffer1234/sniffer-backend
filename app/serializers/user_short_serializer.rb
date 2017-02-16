class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :avatar

  def avatar
    {
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb)
    }
  end
end
