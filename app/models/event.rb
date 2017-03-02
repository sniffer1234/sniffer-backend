class Event < ApplicationRecord

  # Third part
  has_attached_file :cover, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  # Relations
  belongs_to :user
  belongs_to :establishment

  # Validations
  accepts_nested_attributes_for :establishment
  validates_length_of :suggestion_message, maximum: 500, allow_blank: true
  validates_presence_of :name, :description, :starts_at, :ends_at
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Events created by default users and not aprooved
  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

  scope :group_by_date, -> {
    where(aprooved: true)
    .where("ends_at > ?", Time.zone.now)
    .order(:starts_at)
    .group_by{ |event| event.starts_at.to_date }
  }

  # Return events approoved by establishments
  scope :by_establishment, -> (id) {
    where(establishment_id: id)
    .where(aprooved: true)
    .where("ends_at > ?", Time.zone.now)
    .order(:starts_at)
  }

  # Return events by name
  scope :by_name, -> (search) {
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  }

  def when
    {
      day: I18n.l(self.starts_at, format: :day),
      month_name: I18n.l(self.starts_at, format: :month_name),
      week_day_name: I18n.l(self.starts_at, format: :week_day_name),
      timing: "#{ I18n.l(self.starts_at, format: :timing_starts) }#{ I18n.l(self.ends_at, format: :timing_ends) rescue nil}",
    }
  end

  # Indicates if the event ends in the same day that he starts
  def ends_in_the_same_day
    self.starts_at.day == self.ends_at.day
  end

  # Indicates if the events ends in the next day
  def ends_in_the_next_day
    (self.starts_at + 1.day).day == self.ends_at.day
  end

  def establishment_name
    self.establishment.name
  end
end
