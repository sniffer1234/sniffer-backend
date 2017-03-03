class Chat < ApplicationRecord

  # Relations
  has_many :chat_messages, -> { order(created_at: :desc) }
  belongs_to :establishment

  # Validations
  validates_associated :establishment

  # Virtual attributes
  attr_accessor :messages
end
