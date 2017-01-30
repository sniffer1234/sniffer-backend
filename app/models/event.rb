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

  scope :group_by_date, -> {
    where(aprooved: true).order(:starts_at).group_by{ |event| event.starts_at.to_date }
  }

  scope :by_establishment, -> (id) {
    where(establishment_id: id, aprooved: true).order(:starts_at)
  }

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

  def establishment_name
    self.establishment.name
  end

  private

  # Prevent to set to attribute if no_time_to_end is checked
  def set_to_time
    if self.no_time_to_end
      self.ends_at = nil
    end
  end
end
