class ListingsController < ApplicationController
    # force sign in for when user is trying to manipulate the listing
    before_action :authenticate_user!, except: [:show]

    # fetch listing based on various situations
    before_action :set_listing, except: [:new, :create, :show, :my]
    before_action :set_listing_all, only: [:show]
    before_action :set_categories, only: [:new, :edit, :destroy_image]
  
    # GET /listings/my
    def my
      @listings = Listing.for_profile(current_user.profile)
    end
  
    # GET /listings/1
    def show
      # if listing is deleted  
      #     when user is not logged in, don't show it 
      #     when user is logged in, dont't show it if the current user is not listing owner
      if @listing.status == "deleted"  && (current_user == nil || !@listing.owned_by?(current_user))
        redirect_to root_path, alert: "Could not find the listing."
      end  
    end
  
    # GET /listings/new
    def new
      # If profile is not upated
      #   force profile update before listing can be created
      if helpers.current_user_profile_updated?
        @listing = Listing.new(profile_id: current_user.profile.id)
      else
        redirect_to edit_myprofile_path, alert: "Please update your details before creating a listing."
      end
    end
  
    # GET /listings/1/edit
    def edit
      # If listing is deleted don't allow edit
      if (@listing.status != "active")
        redirect_to listing_path(@listing), alert: "Can not edit #{@listing.status} listing."
      end
    end
  
    # POST /listings
    def create
      @listing = Listing.new(listing_params)
      # link listing to signed in user
      @listing.profile_id = current_user.profile.id
      if @listing.save
        redirect_to @listing, notice: 'Listing was successfully created.'
      else
        set_categories
        flash_alert_not_saved
        render :new
      end
    end
  
    # PATCH/PUT /listings/1
    def update
        if @listing.update(listing_params)
            redirect_to edit_listing_path(@listing), notice: 'Listing was successfully updated.'
        else
            set_categories
            flash_alert_not_saved
            render :edit
        end  
    end
  
    # DELETE /listings/1
    def destroy
      # don't allow deleted listings to be deleted again
      if @listing.status != "deleted"
        @listing.status = :deleted
        if @listing.save
          redirect_to @listing, notice: 'Listing was successfully disabled.'
        else
          redirect_to @listing, alert: 'Not able to disable the listing.'
        end
      else
        redirect_to @listing, alert: 'Can not delete already deleted item.'
      end
    end

    # DELETE /listings/1/image/1
    def destroy_image
      if (destroy_listing_image)
        redirect_to edit_listing_path(@listing), notice: "The image was successfully removed."
      else
        redirect_to edit_listing_path(@listing), alert: "The image could not be removed."
      end
    end
  
    private
      # To find listing from current user's listings
      def set_listing
        begin
          # To make sure user updates their own listings only fetch listings related to signed in user's profile
          @listing = current_user.profile.listings.find(params[:id])          
        rescue => exception
          redirect_to root_path, alert: "Could not find the listing."
        end
      end

      # To find listing irrespective of current user id for show action
      def set_listing_all
        begin
          @listing = Listing.find(params[:id])
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
      def flash_alert_not_saved
        flash.now[:alert] = "Can not save listing. Please fix the errors to continue."
      end

      # To delete listing image based on index
      def destroy_listing_image 
        begin
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
              return false
          end          
        rescue => exception
          return false
        end
        return true
      end    
end
  