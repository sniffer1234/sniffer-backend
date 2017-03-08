class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :first_name,
             :avatar, :cellphone, :authentication_token,
             :notifications, :facebook_avatar

  def avatar
    {
      medium: object.avatar.url(:medium),
      thumb: object.avatar.url(:thumb),
    }
  end
end
