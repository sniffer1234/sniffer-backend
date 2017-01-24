class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  paginates_per 20

  devise :database_authenticatable, :registerable, :confirmable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates :name, :email, presence: true
  validates :role, :inclusion => { :in => %w(default admin owner) }

  has_many :sniffs
  has_many :events
  has_many :establishments

  enum :role => [ :default, :admin, :owner ]

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

end
