class ProfilesController < ApplicationController
    before_action :authenticate_user!
    before_action :set_profile

    # GET /myprofile
    def show
      # when the user have not updated profile redirect to update
      if !current_user.profile.name
        redirect_to edit_myprofile_path, alert: 'Please update profile!'
      end
    end

    # GET /myprofile/public
    def public
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

    private
      # To retrieve current user profile or create a new if there is none.
      def set_profile
        @profile = current_user.profile || current_user.create_profile
      end
  
      # Only allow name, phone, location and photo
      def profile_params
        params.require(:profile).permit(:name, :phone, :location)
      end
  end
  