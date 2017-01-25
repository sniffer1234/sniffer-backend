class AddressSerializer < ActiveModel::Serializer
  attributes :id, :zipcode, :street, :number, :neighborhood, :latitude, :longitude, :completed

  has_one :city, serializer: CitySerializer
end
