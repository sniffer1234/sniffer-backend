class Sniff < ApplicationRecord

  belongs_to :user, dependent: :destroy, counter_cache: true
  belongs_to :sniffable, polymorphic: true

  validates :user_id, presence: true

end
