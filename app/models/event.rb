class Event < ApplicationRecord

  has_many :imgs, -> { order(:position) }, as: :imageable, dependent: :destroy

  belongs_to :user
  belongs_to :establishment

  accepts_nested_attributes_for :imgs, allow_destroy: true

  validates_presence_of :name, :description, :when

  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

end
