class Suggestion < ApplicationRecord

  # Relations
  belongs_to :user

  # Validation
  validates :content, presence: true
  validates_length_of :content, maximum: 1500

end
