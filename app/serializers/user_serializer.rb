class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :first_name, :uid, :provider, :tokens
end
