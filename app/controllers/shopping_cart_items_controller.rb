class ShoppingCartItemsController < ApplicationController
  def show
  end

  def update
  end

  def destroy
  end

  def remove
  	@shopping_cart.remove(@listing, 1)
  end
end
