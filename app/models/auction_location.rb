class AuctionLocation < ApplicationRecord
  belongs_to :auction
  belongs_to :address
end
