class Establishment < ApplicationRecord

  # Kaminati pagination
  paginates_per 20

  before_validation :format_url

  has_many :imgs, -> { order(:position) }, as: :imageable, dependent: :destroy
  has_one :address, as: :imageable, dependent: :destroy
  has_many :tags, dependent: :destroy

  accepts_nested_attributes_for :imgs, :address, allow_destroy: true

  validates_presence_of :name, :small_description, :description, :phone
  validates_length_of :small_description, :in => 30..150
  attr_accessor :completed_address

  scope :pending, -> {
    where(aprooved: false, active: true).limit(5)
  }

  # Search local by city name
  # @param params - { Hash } - Hash params
  def self.by_city(params)
    includes(:address).where(addresses: { city_id: params[:city_id] })
  end

  # Search local by name
  # @param search - { String } - Name to be found
  def self.by_name(search)
    return all if !search.present?
    where("name ILIKE ?", "%#{search}%")
  end

  def image
    'http://leocoelho.com/website/wp-content/uploads/2012/12/Pacha-Floripa-reformada.jpg'
  end

  def completed_address
    self.address.completed
  end

  def cover
    {
      source: if self.imgs.size > 0 then self.imgs.first.src.url(:medium) else "#{ ENV['S3_DEFAULT_PATH'] }/default/medium/missing.png" end
    }
  end

  private
  def format_url
    ['site', 'facebook', 'instagram'].each do |attr|
      unless self[attr].blank?
        self[attr] = "http://#{self[attr]}" unless self[attr][/^https?/]
      end
    end
  end

end
