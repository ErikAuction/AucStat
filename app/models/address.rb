class Address < ApplicationRecord
  has_many :auction_locations
  has_many :auctions, through: :auction_locations
end
