class City < ApplicationRecord

  # Relations
  belongs_to :state
  has_many :establishments
  has_many :address

  # Validations
  validates_presence_of :state
end
