class ListingsController < ApplicationController
  before_action :set_listing, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, only: [:seller, :new, :create, :edit, :update, :destroy]
  before_filter :check_user, only: [:edit, :update, :destroy]
  

  # GET /listings
  # GET /listings.json
  def seller
    @listings = Listing.where(user: current_user).order("created_at DESC")
  end
  def shop
    @listings = Listing.where(user: Listing.find(params[:id])).order("created_at DESC").page(params[:page]).per(8)
    @user = User.find(params[:id]) 
  end 
  # For the Shopping cart
  def remove
    @listing = Listing.find(params[:id])
    @shopping_cart.remove(@listing, 1)
  end
  
  def index
    if params[:category].blank?
      @listings = Listing.all.order("created_at DESC").page(params[:page]).per(8)
    else
      @category_id = Category.find_by(name: params[:category]).id
      @listings = Listing.where(category_id: @category_id).order("created_at DESC").page(params[:page]).per(8)
    end
  end

  # GET /listings/1
  # GET /listings/1.json
  def show
    @listing = Listing.find(params[:id])
  end

  # GET /listings/new
  def new
    @listing = Listing.new
  end

  # GET /listings/1/edit
  def edit
  end

  # POST /listings
  # POST /listings.json
  def create
    @listing = Listing.new(listing_params)
    @listing.user_id = current_user.id

    if current_user.recipient.blank?
      Stripe.api_key = ENV["STRIPE_API_KEY"]
      token = params[:stripeToken]

      recipient = Stripe::Recipient.create(

        :name => current_user.name,
        :type => "individual",
        :bank_account => token
        )
    end
    current_user.recipient = recipient.id
    current_user.save

    respond_to do |format|
      if @listing.save
        format.html { redirect_to @listing, notice: 'Product has been successfully created. Thanks!' }
        format.json { render :show, status: :created, location: @listing }
      else
        format.html { render :new }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /listings/1
  # PATCH/PUT /listings/1.json
  def update
    respond_to do |format|
      if @listing.update(listing_params)
        format.html { redirect_to @listing, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @listing }
      else
        format.html { render :edit }
        format.json { render json: @listing.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /listings/1
  # DELETE /listings/1.json
  def destroy
    @listing.destroy
    respond_to do |format|
      format.html { redirect_to listings_url, notice: 'Product was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_listing
      @listing = Listing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def listing_params
      params.require(:listing).permit(:name, :description, :price, :image, :user_id, :category_id)
    end
    def check_user
      if current_user != @listing.user
        format.html { redirect_to root_url, alert: 'Sorry, you can not access that page.' }
      end
    end
end
