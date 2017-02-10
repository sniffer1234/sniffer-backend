class ChatMessage < ApplicationRecord

  paginates_per 10

  # Relations
  belongs_to :chat, counter_cache: :chat_messages_count
  belongs_to :user

  # Validation
  validates_associated :chat, :user
  validates :content, presence: true
  validates :content, length: { maximum: 500, minimum: 1 }

end
