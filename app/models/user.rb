class User < ApplicationRecord
  include TokenHelper

  has_settings do |s|
    s.key :notifications, defaults: {
      email: false,
      push: true
    }
  end

  # Callbacks
  before_validation :generate_password
  before_validation :set_avatar

  # Third part
  paginates_per 20

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_attached_file :avatar, styles: {
    large: '600x600#',
    medium: '300x300#',
    thumb: '150x150#'
   }, default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

   # Valdations
  validates :name, :email, presence: true
  validates :role, inclusion: { in: %w(default admin owner) }
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/jpg"] }, size: { in: 0..10.megabytes }

  # Relations
  has_many :authentications, dependent: :destroy
  has_many :identities, dependent: :destroy
  has_many :sniffs, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :establishments, dependent: :destroy
  has_many :suggestions, dependent: :destroy
  has_many :user_establishments
  has_many :establishments, through: :user_establishments

  enum role: [ :default, :admin, :owner ]

  attr_accessor :auto_password, :email_notification,
                :push_notification, :avatar_data


  # Find last 5 users registred
  scope :newest, -> {
    order(created_at: :desc).limit(5)
  }

  # Find most active users
  scope :activers, -> {
    order(sign_in_count: :desc, sniffs_count: :desc).limit(5)
  }

  # Find user by name
  scope :by_name, -> (search) {
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  }

  def find_for_authentication(warden_conditions)
    find_by(email: warden_conditions[:email])
  end

  def self.find_for_oauth(auth)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user

    # Create the costumer if needed
    if user.nil?
      user = User.find_by(email: auth[:email]) rescue nil

      # Create the user if it's a new registration
      if user.nil?
        user = User.new(
          name: auth[:name],
          email: auth[:email],
          auto_password: true
        )

        user.save!
      end
    end

    if identity.user.nil?
      identity.user = user
      identity.save!
    end

    user
  end

  # Return if user has admin role
  def admin?
    self.role == 'admin'
  end

  # Return if user has admin role
  def owner?
    self.role == 'owner'
  end

  # Return if user has default role
  def default?
    self.role == 'default'
  end

  def role
    if self[:role] != 'admin' && self.establishments.size > 0
      return 'owner'
    end

    return self[:role]
  end

  def after_database_authentication
    self.authentications.build().save!
  end

  def authentication_token
    current_authentication.token if self.current_authentication
  end

  def current_authentication
    authentication = self.authentications.last
  end

  # Expire user session
  def expire!
    Authentication.expire!(self.current_authentication.id)
  end

  # Return user first name
  def first_name
    self.name.split(' ').first
  end

  def notifications
    {
      email: self.settings(:notifications).email,
      push: self.settings(:notifications).push
    }
  end

  def facebook_identity
    self.identities.find_by(provider: "facebook")
  end

  protected

  # Gera senha de forma automatica
  def generate_password
    if self.auto_password
      self.password = TokenHelper::TokenGenerator.generate(4)
      self.password_confirmation = self.password
    end
  end

  def set_avatar
    unless self.avatar_data.blank?
      self.avatar = self.avatar_data
      self.avatar_file_name = "file.jpeg"
      self.avatar_content_type = "image/jpeg"
    end
  end
end
