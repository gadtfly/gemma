class SellersController < ApplicationController
	def create
		@seller = Seller.new#(seller_params)
		@seller.user = current_user
		@seller.save
		redirect_to listings_path
	end

	def update
		# authorize current_user
		@seller = Seller.find(params[:id])
		@seller.update_attributes(seller_params)
		redirect_to :back
	end

	def index
		# authorize current_user		# SellerPolicy#index... current_user.admin
		@confirmed_sellers = Seller.where(confirmed: true)
		@unconfirmed_sellers = Seller.where(confirmed: false)
	end

	def seller_params
		# if current_user.admin
			params.require(:seller).permit(:confirmed)
		# else
		# 	params.require(:seller)
		# end
	end
end
