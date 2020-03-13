class HomeController < ApplicationController
  def index
    if user_signed_in?
      if helpers.current_user_profile_updated?
        @listings = Listing.active.where.not(profile_id: current_user.profile.id).order(updated_at: :desc)
      else
        redirect_to edit_myprofile_path, alert: "Please update your details before viewing listings."
      end
    else
      @listings = Listing.active.order(updated_at: :desc)
    end
  end

  def not_found
    render 'not_found', status: 404
  end
end