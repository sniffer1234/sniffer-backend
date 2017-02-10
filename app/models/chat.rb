class Chat < ApplicationRecord

  has_many :chat_messages, -> { order(created_at: :asc) }
  belongs_to :establishment

  # Validations
  validates_associated :establishment
  attr_accessor :messages
end
