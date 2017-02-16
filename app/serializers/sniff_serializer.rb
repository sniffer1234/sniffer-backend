class SniffSerializer < ActiveModel::Serializer
  attributes :id, :src, :duration, :time_ago, :user

  def user
    return {
      id: object.user.id,
      name: object.user.name,
      first_name: object.user.first_name,
      avatar: {
        medium: object.user.avatar.url(:medium),
        thumb: object.user.avatar.url(:thumb)
      }
    }
  end

  def src
    return {
      thumb: object.src.url(:thumb),
      large: object.src.url(:large)
    }
  end
end
