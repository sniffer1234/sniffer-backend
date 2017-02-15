class SniffSerializer < ActiveModel::Serializer
  attributes :id, :src, :duration
  has_one :user, serializer: UserShortSerializer

  def duration
    return 5000
  end
end
