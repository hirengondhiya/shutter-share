module ApplicationHelper
    def remove_profile_photo? profile
        params[:controller] == "profiles" && params[:action] == "edit" && profile.picture.attached?
    end

    def if_empty_default_message data_value
        data_value || "Awaiting details"
    end

    def show_listing_delete?
        params[:controller] == "listings" && (params[:action] == "edit" || params[:action] == "show")
    end
end
