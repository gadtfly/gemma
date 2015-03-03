class ShoppingCartsController < ApplicationController
  include CurrentCart 
  before_action :set_cart, only: [:create] 

  def create
    @listing = Listing.find(params[:listing_id])
    @shopping_cart.add(@listing, @listing.price, 1)
    redirect_to cart_path
  end
  def show
    
  end
  def edit
    
  end
  def checkout
  	@shopping_cart.shopping_cart_items do |sci|
  		      
      sci.shopping_cart_id = nil 
      items << sci 
    end
  end
  def destroy
    
  end
  def update
    
  end
end
