class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_filter :extract_shopping_cart
  rescue_from Pundit::NotAuthorizedError do |exception|
     redirect_to root_url, alert: exception.message
 	end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) << :name
    devise_parameter_sanitizer.for(:account_update) << :name

  end
  private
  def extract_shopping_cart
    shopping_cart_id = session[:shopping_cart_id]
    @shopping_cart = session[:shopping_cart_id] ? ShoppingCart.find(shopping_cart_id) : ShoppingCart.create
    session[:shopping_cart_id] = @shopping_cart.id
  end
end
