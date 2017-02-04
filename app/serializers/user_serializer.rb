class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :first_name, :avatar, :cellphone, :authentication_token, :notifications

  def avatar
    {
      large: object.avatar.url(:large),
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
      original: object.avatar.url(:original)
    }
  end
end
