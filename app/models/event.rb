class Event < ApplicationRecord

  has_many :imgs, -> { order(:position) }, as: :imageable, dependent: :destroy

  belongs_to :user
  belongs_to :establishment

  validates_presence_of :description, :when

  scope :pending, -> {
    where(aprooved: false, active: true).limit(5)
  }

end
