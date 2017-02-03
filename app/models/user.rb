class User < ApplicationRecord
  include TokenHelper

  has_settings do |s|
    s.key :notifications, defaults: { email: false, push: true }
  end

  # Callbacks
  before_validation :generate_password
  before_validation :set_avatar

  # Third part
  paginates_per 20

  devise :database_authenticatable, :registerable,
         :confirmable, :recoverable, :rememberable,
         :trackable, :validatable, :omniauthable

  has_attached_file :avatar, styles: {
    medium: '300x300#',
    thumb: '150x150#'
   }, default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

   # Valdations
  validates :name, :email, presence: true
  validates :role, inclusion: { in: %w(default admin owner) }
  validates_attachment :avatar, content_type: { content_type: ["image/jpg", "image/jpeg", "image/jpg"] }, size: { in: 0..10.megabytes }

  # Relations
  has_many :authentications
  has_many :identities
  has_many :sniffs
  has_many :events
  has_many :establishments

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

  def self.find_for_oauth(auth, signed_in_resource = nil)
    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)

    # If a signed_in_resource is provided it always overrides the existing user
    # to prevent the identity being locked with accidentally created accounts.
    # Note that this may leave zombie accounts (with no associated identity) which
    # can be cleaned up at a later date.
    user = identity.user

    # Create the costumer if needed
    if user.nil?

      email = auth.info.email
      user = User.where(email: email).first if email

      # Create the user if it's a new registration
      if user.nil?

        user = User.new(
          name: auth.extra.raw_info.name,
          email: email,
          auto_password: true
        )

        # Não é necessário confirmar a conta (padrao é)
        user.skip_confirmation!
        user.save!
      end
    end


    # Associa com o usuário
    identity.user = user
    identity.save!

    user
  end

  def authentication_token
    current_authentication.token if self.current_authentication
  end

  def current_authentication
    authentication = self.authentications.last
  end

  def expire!
    Authentication.expire!(self.current_authentication.id)
  end

  def after_database_authentication
    self.authentications.build().save!
  end

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

  def facebook_avatar
    facebook_identity = self.facebook_identity

    if facebook_identity
      return "https://graph.facebook.com/#{ facebook_identity.uid }/picture?type=large"
    end
  end

  protected

  # Gera senha de forma automatica
  def generate_password
    if self.auto_password
      self.password = TokenHelper::TokenGenerator.generate(6)
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
