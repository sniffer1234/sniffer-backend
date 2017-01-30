class Event < ApplicationRecord
  before_save :set_to_time

  has_many :imgs, -> { order(:position) }, as: :imageable, dependent: :destroy

  belongs_to :user
  belongs_to :establishment

  accepts_nested_attributes_for :establishment, :imgs, allow_destroy: true
  validates_presence_of :name, :description, :starts_at

  # Events created by default users and not aprooved
  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

  # Group events by date
  scope :group_by_date, -> {
    all.where(aprooved: true).order(:starts_at).group_by{ |event| event.starts_at.to_date }
  }

  # Search event by name
  # @param search - { String } - Name to be found
  def self.by_name(search)
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  end

  # Search event by establishment id
  # @param establishment - { Object } - establishment to filter
  def self.by_establishment(establishment)
    return all if !establishment.present?
    where(establishment_id: establishment.id)
  end

  private

  # Prevent to set to attribute if no_time_to_end is checked
  def set_to_time
    if self.no_time_to_end
      self.ends_at = nil
    end
  end

end
