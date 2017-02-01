class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :first_name, :avatar, :cellphone, :authentication_token, :notifications
end
