class HomeController < ApplicationController
  def index
    if user_signed_in?
      if helpers.current_user_profile_updated?
        @listings = Listing.all.where.not(profile_id: current_user.profile.id)
      else
        redirect_to edit_myprofile_path, alert: "Please update your details before viewing listings."
      end
    else
      @listings = Listing.all
    end
  end
end