class ShoppingCartsController < ApplicationController
  include CurrentCart 
  before_action :set_cart, only: [:create] 

	def create
    @listing = Listing.find(params[:listing_id])
    @shopping_cart.add(@listing, @listing.price)
    redirect_to :backend
  end
  def show
  	
  end

  def checkout
  	@shopping_cart.shopping_cart_items do |sci|
  		# shopping_cart_item.item
  		# shopping_cart_item.item.listing
  		# insert stripe stuff here
       
      sci.shopping_cart_id = nil 
      items << sci 
    end
  end
end
