class UserEstablishment < ApplicationRecord

  # Relations
  belongs_to :user
  belongs_to :establishment
end
