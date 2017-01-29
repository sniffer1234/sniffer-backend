class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  before_create :set_default_values

  paginates_per 20

  enum :role => [ :default, :admin, :owner ]

  devise :database_authenticatable, :registerable, :confirmable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_attached_file :avatar, styles: {
    medium: '300x300#',
    thumb: '150x150#'
   }, default_url:  "#{ Rails.application.secrets.amazon_s3_path }/default/:style/missing.png"

  validates :name, :email, presence: true
  validates :role, :inclusion => { :in => %w(default admin owner) }
  validates_attachment :avatar,
    content_type: {
      content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"]
    }

  has_many :sniffs
  has_many :events
  has_many :establishments

  scope :newest, -> {
    order(created_at: :desc).limit(5)
  }
  scope :activers, -> {
    order(sign_in_count: :desc, sniffs_count: :desc).limit(5)
  }

  def token_validation_response
    UserSerializer.new(self, root: false).as_json
  end

  def first_name
    self.name.split(' ').first
  end

  # Search local by name
  # @param search - { String } - Name to be found
  def self.by_name(search)
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  end

  private
  def set_default_values
    self.tokens = nil
  end

end
