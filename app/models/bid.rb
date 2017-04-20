class Bid < ApplicationRecord
  belongs_to :auction
  belongs_to :stock
end
