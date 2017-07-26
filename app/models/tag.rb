class Tag < ApplicationRecord

  paginates_per 20

  # Callbacks
  before_save :set_alias

  # Paperclip
  has_attached_file :avatar,
    styles: { large: "600x600#", medium: "300x300#", thumb: "40x40#", micro: "10x10#" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  # Relations
  has_and_belongs_to_many :establishments

  # Validations
  validates_presence_of :name
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  private
  def set_alias
    self.alias = self.name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

end
