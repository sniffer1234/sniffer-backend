class SniffSerializer < ActiveModel::Serializer
  attributes :id, :img, :video, :duration, :time_ago

  has_one :user, serializer: UserShortSerializer

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
