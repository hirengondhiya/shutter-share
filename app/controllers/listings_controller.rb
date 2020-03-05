class ListingsController < ApplicationController
    before_action :set_listing, only: [:show, :edit, :update, :destroy]
    before_action :set_categories, only: [:new, :edit]
  
    # GET /listings
    def index
      @listings = Listing.all
    end
  
    # GET /listings/1
    def show
    end
  
    # GET /listings/new
    def new
      @listing = Listing.new(profile_id: current_user.profile.id)
    end
  
    # GET /listings/1/edit
    def edit
    end
  
    # POST /listings
    def create
      @listing = Listing.new(listing_params)
      @listing.profile_id = current_user.profile.id
      if @listing.save
        redirect_to @listing, notice: 'Listing was successfully created.'
      else
        render :new, @listing
      end
    end
  
    # PATCH/PUT /listings/1
    def update
        if @listing.update(listing_params)
            redirect_to @listing, notice: 'Listing was successfully updated.'
        else
            render :edit
        end  
    end
  
    # DELETE /listings/1
    def destroy
    #   @listing.update(status: )
    #   redirect_to listings_url, notice: 'Disabled the listing.'
    end

    # DELETE /listings/1/image/1
    def destroy_image
    #   @listing.update(status: )
    #   redirect_to listings_url, notice: 'Disabled the listing.'
    end
  
    private
      # To find listing from current user's listings
      def set_listing
        begin
          @listing = current_user.profile.listings.find(params[:id])          
        rescue => exception
          redirect_to root_path, alert: "Could not find the listing."
        end
      end
  
      # Only allow title, description, category, brand, model, rate and images
      def listing_params
        params.require(:listing).permit(:title, :description, :category, :brand, :model, :rate, :image1, :image2, :image3, :image4, :image5)
      end

      def set_categories
        @categories = Listing.categories.keys
      end   
end
  