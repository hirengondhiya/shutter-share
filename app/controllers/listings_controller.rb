class ListingsController < ApplicationController
    before_action :set_listing, except: [:index, :new, :create]
    before_action :set_categories, only: [:new, :edit, :destroy_image]
  
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
        set_categories
        flas_alert_not_saved
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
        if @listing.update(listing_params)
            redirect_to @listing, notice: 'Listing was successfully updated.'
        else
            set_categories
            flas_alert_not_saved
            render :edit
        end  
    end
  
    # DELETE /listings/1
    def destroy
      @listing.status = :deleted
      if @listing.save
        redirect_to @listing, notice: 'Listing was successfully disabled.'
      else
        redirect_to @listing, alert: 'Not able to disable the listing.'
      end  
    end

    # DELETE /listings/1/image/1
    def destroy_image
      case params[:index]
        when "1"
          @listing.image1.purge
        when "2"
          @listing.image2.purge
        when "3"
          @listing.image3.purge
        when "4"
          @listing.image4.purge
        when "5"
          @listing.image5.purge
        else
          image_not_found = true
      end
      if (image_not_found)
        flash.now[:alert] = "Image not found."
      else
        flash.now[:notice] = "The image was successfully removed."
      end
      render 'edit'
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

      # To show categories radio options
      def set_categories
        @categories = Listing.categories.keys
      end
      
      # To show alert when listing was not saved successfully.
      def flas_alert_not_saved
        flash.now[:alert] = "Can not save listing. Please fix the errors to continue."
      end
end
  