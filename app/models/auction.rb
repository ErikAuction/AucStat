class Auction < ApplicationRecord
  has_many :auction_locations
  has_many :addresses, through: :auction_locations
  has_many :bids
  has_many :stock


  def show
    respond_to do |format|
      format.js {render layout: false} 
    end
  end

end
