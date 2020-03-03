class ProfilesController < ApplicationController
    before_action :set_profile

    # GET /myprofile
    def show
    end

    # GET /myprofile/public
    def public
    end
    
    # GET /myprofile/edit
    def edit
    end
  
    # PATCH/PUT /myprofile
    def update
      respond_to do |format|
        if @profile.save(profile_params)
            redirect_to @profile, notice: 'Profile was successfully saved.'
        else
            render :edit
        end
      end
    end

    private
      # To retrieve current user profile or create a new if there is none.
      def set_profile
        @profile = current_user.profile || Profile.new(user_id: current_user.id)
      end
  
      # Only allow name, phone, location and photo
      def profile_params
        params.require(:profile).permit(:name, :phone, :location)
      end
  end
  