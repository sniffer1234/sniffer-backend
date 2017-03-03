class Tag < ApplicationRecord

  paginates_per 50

  # Callbacks
  before_save :set_alias

  # Relations
  has_and_belongs_to_many :establishments

  # Validations
  validates_presence_of :name

  private
  def set_alias
    self.alias = self.name.downcase.gsub(/[^a-z1-9]+/, '-').chomp('-')
  end

end
