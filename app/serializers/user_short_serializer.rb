class UserShortSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name,
             :avatar, :facebook_avatar

  def avatar
    if object.avatar_file_size & !object.facebook_identity
      return {
        medium: object.avatar.url(:medium),
        thumb: object.avatar.url(:thumb)
      }
    else
      return {
        medium: "https://graph.facebook.com/#{ object.facebook_identity.uid }/picture?width=150&height=150",
        thumb: "https://graph.facebook.com/#{ object.facebook_identity.uid }/picture?width=300&height=300"
      }
    end
  end
end
