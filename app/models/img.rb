class Img < ApplicationRecord

  # Callbacks
  before_save :set_position

 # Relations
 belongs_to :imageable, polymorphic: true

 # Relations
 has_attached_file :src, styles: {
   medium: '300x300#',
   thumb: '150x150#'
  }, default_url:  "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.jpg"

 # Validations
 validates_presence_of :imageable_id, :imageable_type, :src
 validates_attachment :src, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }

 def source
   self.src.url(:medium)
 end

 protected
 def set_position
   1
  #  unless self.position
  #    amount = self.local.imgs.size || 0
  #    self.position = amount + 1
  #  end
 end
end
