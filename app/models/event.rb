class Event < ApplicationRecord

  has_many :imgs, -> { order(:position) }, as: :imageable, dependent: :destroy

  belongs_to :user
  belongs_to :establishment

  accepts_nested_attributes_for :establishment, :imgs, allow_destroy: true

  validates_presence_of :name, :description, :when, :from, :to

  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

  scope :group_by_date, -> {
    all.where(aprooved: true).order(:when).group_by{ |event| event.when.to_date }
  }

  # Search local by name
  # @param search - { String } - Name to be found
  def self.by_name(search)
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  end

  def self.by_establishment(establishment)
    return all if !establishment.present?
    where(establishment_id: establishment.id)
  end

end
