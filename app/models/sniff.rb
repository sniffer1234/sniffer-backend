include ActionView::Helpers::DateHelper

class Sniff < ApplicationRecord

  paginates_per 10

  # Callbacks
  before_validation :set_img, unless: Proc.new{ |s| s.img_data.blank? }
  before_validation :set_video, unless: Proc.new{ |s| s.video_data.blank? }

  # Paperclip image
  has_attached_file :img,
    styles: { medium: "480x640>", large: "810x1080>", thumb: "24x32>" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_attached_file :video,
    styles: { medium: { geometry: "480x640>", format: 'mp4' } },
    processors: [ :transcoder ]

  # Relations
  belongs_to :user, counter_cache: true
  belongs_to :sniffable, polymorphic: true

  # Validations
  validates :user_id, presence: true
  validates_attachment_content_type :img, content_type: ['image/jpg', 'image/jpeg']
  validates_attachment_content_type :video, content_type: ['video/mp4']

  before_video_post_process :set_video_duration

  attr_accessor :img_data, :video_data

  # Find sniffs by establishment id
  scope :by_establishment, -> (id) {
    return all if !id.present?
    where(sniffable_type: 'Establishment', sniffable_id: id)
  }

  # Return created at with time_ago helper
  def time_ago
    "#{ time_ago_in_words(self.created_at) } atrás"
  end

  def establishment_name
    self.sniffable.name
  end

  private

  def set_img
    self.img = self.img_data
    self.img_file_name = "file.jpeg"
    self.img_content_type = "image/jpeg"
  end

  def set_video
    self.video = self.video_data
    self.video_file_name = "file.mp4"
    self.video_content_type = "video/mp4"
  end

  def set_video_duration
    result = `ffmpeg -i #{self.video.staged_path} 2>&1`

    r = result.match("Duration: ([0-9]+):([0-9]+):([0-9]+).([0-9]+)")
    duration = "#{ r[1].to_i*3600+r[2].to_i*60+r[3].to_i }.#{ r[1].to_i*3600+r[2].to_i*60+r[4].to_i }".to_f

    self.duration = duration.round * 1000
  end



end
