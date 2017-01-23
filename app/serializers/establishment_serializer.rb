class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :email,
             :phone, :site, :facebook, :instagram,
             :vip
end
