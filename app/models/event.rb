class Event < ApplicationRecord
  before_save :set_to_time

  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  belongs_to :user
  belongs_to :establishment

  accepts_nested_attributes_for :establishment
  validates_presence_of :name, :description, :starts_at
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Events created by default users and not aprooved
  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

  scope :to_happen, -> {
    where("starts_at >= ?", Time.zone.now)
  }

  # Group events by date
  scope :group_by_date, -> {
    all.where(aprooved: true).order(:starts_at).group_by{ |event| event.starts_at.to_date }
  }

  def establishment_name
    self.establishment.name
  end

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
