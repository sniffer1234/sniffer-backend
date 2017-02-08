class ChatMessageSerializer < ActiveModel::Serializer
  attributes :id, :content, :created_at, :user

  def user
    {
      id: object.user.id,
      name: object.user.name,
      first_name: object.user.first_name
    }
  end

  def created_at
    I18n.l(object.created_at, format: :abbreviated)
  end
end
