class Tag < ApplicationRecord

  validates :alias, :inclusion => { :in => %w(restaurant event beverage_distributor
    bar nightclub pizzaria steak_house pastry_chop japanese lunch dinner arabic) }

  enum :alias => [ :restaurant, :event, :beverage_distributor,
    :bar, :nightclub, :pizzaria, :steak_house,
    :pastry_chop, :japanese, :lunch, :dinner, :arabic
  ]

  belongs_to :establishment
  validates_presence_of :establishment, :alias

  def name
    I18n.t(self.alias)
  end

end
