class Event < ApplicationRecord

  # Third part
  has_attached_file :avatar,
    styles: {
      large: "600x600#",
      medium: "300x300#",
      thumb: "65x65#",
      micro: "10x10#"
    },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_attached_file :cover,
    styles: {
      large: "600x450#",
      medium: "400x300#",
      thumb: "80x60#",
      micro: "10x10#"
    },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  # Relations
  belongs_to :user
  belongs_to :establishment

  # Validations
  accepts_nested_attributes_for :establishment
  validates_presence_of :name, :description, :small_description, :starts_at, :ends_at
  validates_length_of :small_description, :in => 30..350
  validates_length_of :description, minimum: 30
  validates_length_of :suggestion_message, maximum: 500, allow_blank: true
  validate :starts_at_greater_than_ends_at
  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Events created by default users and not aprooved
  scope :pending, -> {
    where(aprooved: false).limit(5)
  }

  # Filter by tags
  scope :by_tags, -> (tags) {
    return all unless tags.present?
    includes(:establishment)
    .joins(establishment: :tags)
    .where(establishment: { tags: { alias: [tags.split(',')]} })
  }

  scope :group_by_date, -> {
    where(aprooved: true, visible: true)
    .where("ends_at > ?", Time.zone.now)
    .order(:starts_at)
    .group_by{ |event| event.starts_at.to_date }
  }

  # Return events approoved by establishments
  scope :by_establishment, -> (id) {
    where(establishment_id: id)
    .where(aprooved: true, visible: true)
    .where("ends_at > ?", Time.zone.now)
    .order(:starts_at)
  }

  # Return events by name
  scope :by_name, -> (search) {
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  }

  def tags
    self.establishment.tags.limit(2)
  end

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

  # Indicate establishment name
  def establishment_name
    self.establishment.name
  end

  protected

  # Check if starts_at is greater than ends_at
  def starts_at_greater_than_ends_at
    if self.starts_at && self.ends_at

      if self.starts_at > self.ends_at
        errors.add(:starts_at, :must_be_greater_than_ends_at)
      end
    end
  end
end
