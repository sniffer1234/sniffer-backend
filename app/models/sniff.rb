class Sniff < ApplicationRecord

  # Callbacks
  before_validation :set_src

  has_attached_file :src,
    styles: { thumb: "120x80>" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  # Relations
  belongs_to :user, dependent: :destroy, counter_cache: true
  belongs_to :sniffable, polymorphic: true

  # Validations
  validates :user_id, presence: true
  validates_attachment_content_type :src,
    content_type: ['image/jpg', 'image/jpeg', 'video/mp4']

  attr_accessor :src_data

  private
  def set_src
    unless self.src_data.blank?
      self.src = self.src_data
      self.src_data = "file.jpeg"
      self.src_data = "image/jpeg"
    end
  end

end
