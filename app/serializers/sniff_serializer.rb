class SniffSerializer < ActiveModel::Serializer
  attributes :id, :img, :video, :duration, :time_ago, :user

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

  def img
    unless object.img_file_size.nil?
      return {
        thumb: object.img.url(:thumb),
        large: object.img.url(:large)
      }
    end

    return nil
  end

  def video
    unless object.video_file_size.nil?
      return {
        medium: object.video.url(:medium)
      }
    end

    return nil
  end
end
