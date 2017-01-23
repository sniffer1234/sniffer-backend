class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable, :confirmable,
          :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  validates_presence_of :name, :email

  def token_validation_response
    UserSerializer.new( self, root: false ).as_json
  end

  def first_name
    self.name.split(' ').first
  end

end
