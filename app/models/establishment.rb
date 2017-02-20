class Establishment < ApplicationRecord

  # Kaminati pagination
  paginates_per 10

  before_validation :format_url
  before_create :create_chat

  has_attached_file :avatar,
    styles: { default: "40x40>" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_attached_file :cover,
    styles: { medium: "300x300>", thumb: "100x100>" },
    default_url: "#{ ENV['S3_DEFAULT_PATH'] }/default/:style/missing.png"

  has_one :address, as: :addressable, dependent: :destroy
  has_one :chat, dependent: :destroy
  has_many :sniffs, as: :sniffable, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :events, dependent: :destroy
  has_many :tags, dependent: :destroy

  belongs_to :user

  accepts_nested_attributes_for :address, allow_destroy: true

  validates_presence_of :name, :small_description, :description, :phone
  validates_length_of :small_description, :in => 30..250
  validates_length_of :description, :in => 30..1500
  validates_length_of :suggestion_message, maximum: 500, allow_blank: true

  validates_attachment_content_type :cover, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]
  validates_attachment_content_type :avatar, :content_type => ["image/jpg", "image/jpeg", "image/png", "image/gif"]

  scope :pending, -> {
    all.where(aprooved: false).limit(5)
  }

  scope :available, -> {
    all.where(visible: true, aprooved: true).order(:name)
  }

  scope :by_name, -> (search) {
    return all unless search.present?
    where("name ILIKE ?", "%#{search}%")
  }

  scope :by_tags, -> (tags) {
    return all unless tags.present?
    joins(:tags).where(tags: { alias: [tags.split(',')]})
  }

  scope :with_sniffs, -> () {
    includes(:sniffs)
    .where.not(sniffs: { id: nil })
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
