class Authentication < ActiveRecord::Base
  include ActiveModel::Dirty
  include TokenHelper

  # Callbacks
  before_create :create_token
  before_save   :renew_expiration

   # Relations
  belongs_to :user

  # Expira token
  def self.expire!(authentication_id)
    return false unless authentication_id

    a = Authentication.find(authentication_id)
    a.expiration = Time.zone.now - 24.hour

    a.save!
  end

  # Retorna se token está expirado
  def expired?
    Time.zone.now > self.expiration ? true : false
  end

  protected
  def create_token
    self.token = TokenHelper::TokenGenerator.generate
  end

  # Renova expiração
  def renew_expiration
    self.expiration = Time.zone.now + 1.month if self.expiration == self.expiration_was
  end

end
