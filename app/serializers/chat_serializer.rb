class ChatSerializer < ActiveModel::Serializer
  attributes :id
  has_many :messages, serializer: ChatMessageSerializer
end
