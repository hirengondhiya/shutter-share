class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :force_update_current_user_profile, except: [:edit, :update]
    before_action :set_profile

    # GET /myprofile
    def show
    end

    # GET /myprofile/public
    # GET /userprofile/:id
    def public
      @active_listings = Listing.for_profile(@profile.id).active
    end
    
    # GET /myprofile/edit
    def edit
    end
  
    # PATCH/PUT /myprofile
    def update
      if @profile.update(profile_params)
        redirect_to myprofile_path, notice: 'Profile was successfully saved.'
      else
        render :edit
      end
    end

    # DELETE /myprofile/delete_picture
    def destroy_picture
      @profile.picture.purge

      if @profile.errors.any?
        redirect_to edit_myprofile_path, alert: 'Errors prevented removing the image.'
      else
        redirect_to edit_myprofile_path, notice: 'Profile photo deleted.'
      end
    end

    private
      # To retrieve user profile
      def set_profile
        # when accessing other user's profile
        if request.env['PATH_INFO'].match?("/userprofile/")
          @profile = Profile.find(params[:id])
        # when accessing own profile
        else
          # create a new profile for current user if there is none.
          @profile = current_user.profile || current_user.create_profile
        end
      end

      # when the user have not updated profile redirect to update
      def force_update_current_user_profile
        # To be sure if user profile has some details
        # need to check both if user profile exists and if profile has a name 
        # since profile is created first time the app renders edit form
        if !current_user.profile || !current_user.profile.name
          redirect_to edit_myprofile_path, alert: 'Please first update your profile!'
        end  
      end
  
      # Only allow name, phone, location and photo
      def profile_params
        params.require(:profile).permit(:name, :phone, :location, :picture)
      end
  end
