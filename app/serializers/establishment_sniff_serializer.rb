class EstablishmentSniffSerializer < ActiveModel::Serializer
  attributes :id, :name, :cover, :avatar
  has_one :last_sniff, serializer: SniffSerializer
end
