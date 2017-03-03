include ActionView::Helpers::DateHelper

class Sniff < ApplicationRecord

  paginates_per 10

  # Callbacks
  before_validation :set_src

  # Paperclip image
  has_attached_file :src,
    styles: { medium: "480x640>", large: "810x1080>", thumb: "24x32>" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  # Relations
  belongs_to :user, counter_cache: true
  belongs_to :sniffable, polymorphic: true

  # Validations
  validates :user_id, presence: true
  validates_attachment_content_type :src,
    content_type: ['image/jpg', 'image/jpeg', 'video/mp4']

  attr_accessor :src_data

  # Find sniffs by establishment id
  scope :by_establishment, -> (id) {
    return all if !id.present?
    where(sniffable_type: 'Establishment', sniffable_id: id)
  }

  # Return created at with time_ago helper
  def time_ago
    return "#{ time_ago_in_words(self.created_at) } atrás"
  end

  def establishment_name
    self.sniffable.name
  end

  private
  def set_src
    unless self.src_data.blank?
      self.src = self.src_data
      self.src_data = "file.jpeg"
      self.src_data = "image/jpeg"
    end
  end

end
