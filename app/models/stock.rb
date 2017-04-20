class Stock < ApplicationRecord
  belongs_to :auction
  has_one :bid
  belongs_to :vehicle
end
