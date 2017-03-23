class Establishment < ApplicationRecord

  # Kaminati pagination
  paginates_per 15

  before_validation :format_url
  before_create :create_chat

  has_attached_file :avatar,
    styles: {
      large: "600x600#",
      medium: "300x300#",
      thumb: "40x40#",
      micro: "10x10#"
    },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_attached_file :cover,
    styles: {
      large: "600x450#",
      medium: "400x300#",
      thumb: "80x60#",
      micro: "10x10#"
    },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_one :address, as: :addressable, dependent: :destroy
  has_one :chat, dependent: :destroy
  has_many :sniffs, as: :sniffable, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :events, dependent: :destroy
  has_and_belongs_to_many :tags

  belongs_to :user

  accepts_nested_attributes_for :address, allow_destroy: true

  validates_presence_of :name, :small_description, :description, :phone, :business_hours_description, :small_business_hours_description
  validates_length_of :small_description, :in => 30..350
  validates_length_of :description, minimum: 30
  validates_length_of :small_business_hours_description, :in => 5..35
  validates_length_of :business_hours_description, :in => 15..1500
  validates_length_of :suggestion_message, maximum: 500, allow_blank: true

  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  # Return last 5 establishments to aproove
  scope :pending, -> {
    all.where(aprooved: false).limit(5)
  }

  scope :available, -> {
    all.where(visible: true, aprooved: true).order(:name)
  }

  # Get establishments by name
  scope :by_name, -> (search) {
    return all unless search.present?
    where("name ILIKE ?", "%#{search}%")
  }

  # Get establishments by tags
  scope :by_tags, -> (tags) {
    return all unless tags.present?
    joins(:tags).where(tags: { alias: [tags.split(',')]})
  }

  # Get establishment sniffs created in the last 12hours by user id
  scope :sniffs_by_user_from_last_12_hours, -> (user_id) {
    includes(:sniffs)
    .where.not(sniffs: { id: nil })
    .where(sniffs: { user_id: user_id, created_at: 12.hours.ago..Time.now })
    .order('sniffs.id DESC')
  }

  # Get establishment sniffs created in the last 12hours
  scope :sniffs_from_last_12_hours, -> () {
    includes(:sniffs)
    .where.not(sniffs: { id: nil })
    .where(sniffs: { created_at: 12.hours.ago..Time.now })
    .order('sniffs.id DESC')
  }

  # Search local by city name
  # @param params - { Hash } - Hash params
  def self.by_city(params)
    includes(:address).where(addresses: { city_id: params[:city_id] })
  end

  # Return last sniff
  def last_sniff
    self.sniffs.first rescue nil
  end

  private
  def format_url
    ['site', 'facebook', 'instagram'].each do |attr|
      unless self[attr].blank?
        self[attr] = "http://#{self[attr]}" unless self[attr][/^https?/]
      end
    end
  end

  def create_chat
    self.build_chat
  end

end
