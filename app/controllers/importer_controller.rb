class ImporterController < ApplicationController
  require 'csv'
  before_action :load_locals


  def import

    importer(params[:file])

    #if there was no file selected for import, inform the user
    if params.has_key?(:file)
      redirect_to root_url, notice: "Auction data imported."
    else
      redirect_to root_url, notice: "No file was selected."
    end
  end


  private

    def importer(file)

     if file
        CSV.foreach(file.path, headers: true) do |row|

          params_hash = row.to_hash 
         
          #variables to hold the params used to create/find each of the models to be used for this auction
          address_hash = {}
          vehicle_hash = {}
          auction_hash = {}
          stock_hash = {}
          bid_hash = {}
            
          #create temp variables to be using in parsing the params hash
          temp_auction = Auction.new
          temp_address = Address.new
          temp_vehicle = Vehicle.new
          temp_bid = Bid.new
          temp_stock = Stock.new

          #parse the params_hash for params specific to each needed model
          params_hash.each { |k, v| address_hash[k] = params_hash.delete(k) if temp_address.respond_to?(k) }      #parse parameters for address model
          params_hash.each { |k, v| vehicle_hash[k] = params_hash.delete(k) if temp_vehicle.respond_to?(k) }      #parse parameters for vehicle model
          params_hash.each { |k, v| auction_hash[k] = params_hash.delete(k) if temp_auction.respond_to?(k) }      #parse parameters for auction model
          params_hash.each { |k, v| bid_hash[k] = params_hash.delete(k) if temp_bid.respond_to?(k) }              #parese parameters for bid model
          params_hash.each { |k, v| stock_hash[k] = params_hash.delete(k) if temp_stock.respond_to?(k) }          #parse parameters for stock model

          #using the parsed params, find/create the necessary models to fill out the auction object
          vehicle = Vehicle.find_or_create_by!(vehicle_hash)        #find the vehicle matching the vehicle hash params, or create if does not exist
          address = Address.find_or_create_by!(address_hash)        #find the address matching the address hash params, or create if does not exist
   
          auction = Auction.find_or_create_by!(auction_hash)        #find the auction matching the auction hash params, or create if does not exist

          #there might be stock from different auctions that have the same vehicle stock number, so allow dupes between different auctions
          # and it may be possible that auctions reuse stock numbers after a vehicle is sold.
          #  so identify stock specifically by associated auction and vehicle 
          stock_hash[:auction_id] = auction.id
          stock_hash[:vehicle_id] = vehicle.id
          stock = Stock.find_or_create_by!(stock_hash) 

          #only one bid per stock for auction (only storing winning bid currently)
          bid_hash[:auction_id] = auction.id
          bid_hash[:stock_id] = stock.id
          bid = Bid.find_or_create_by!(bid_hash) do |new_bid|
            new_bid.profit = new_bid["winning bid"].to_i - new_bid["seller payout"].to_i    #calc car sale profit for store and easy later use
            new_bid.save
          end

          #leaving open the possibility that a location may have different auctions held at it at different times (for example, a county fairgrounds)
          # so using AuctionLocation to create the relationship between an auction and an address allowing for multiple auctions to use the same address 
          auction_location = AuctionLocation.find_or_create_by!(auction_id: auction.id, address_id: address.id) do |auction_location|
            auction_location.auction = auction
            auction_location.address = address
            auction_location.save
          end
 

        end
    end
  end

  def load_locals
    @auctions = Auction.all
  end



end
