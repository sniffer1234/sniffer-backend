class EstablishmentSerializer < ActiveModel::Serializer
  attributes :id, :name, :small_description,
             :description, :email, :phone,
            :site, :facebook, :instagram,
             :vip, :cover
end
