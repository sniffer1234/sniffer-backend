class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :small_description,
             :description, :image, :email,
             :phone, :site, :facebook, :instagram,
             :vip
end
