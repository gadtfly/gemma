module CurrentCart 
	extend ActiveSupport::Concern 
private 
def set_cart 
	@cart = ShoppingCart.find(session[:cart_id]) 
rescue ActiveRecord::RecordNotFound 
	@cart = ShoppingCart.create 
	session[:cart_id] = @cart.id 
end 
end 