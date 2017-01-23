class Address < ApplicationRecord

  # Third part
  #geocoded_by :geocode_address

  # Callbacks
  after_validation :remove_zipcode_bar
  after_validation :set_completed_address
#  after_validation :geocode

  # Relationship
  belongs_to :city
  belongs_to :establishment

  # Validation
  validates_presence_of :city, :number, :street, :neighborhood, :zipcode

  protected

  # Set a completed address to avoid joins
  def set_completed_address
    if self.street && self.number
      address = "#{ self.street }, #{ self.number }"

      unless self.complement.blank?
        address += ", #{ self.complement }"
      end

      if self.neighborhood
        address += ", #{ self.neighborhood }"
      end

      if self.city && self.city.state
        address += ", #{ self.city.name } - #{ self.city.state.name }"
      end

      address += " - Brasil"

      self.completed = address
    end
  end

  # Get geocoded attribute
  def geocode_address
    self.completed
  end

  # Remove bars from zipcode to avoid problems with masks
  def remove_zipcode_bar
    self.zipcode = self.zipcode.gsub("-", "") if self.zipcode
  end
end
