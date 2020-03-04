module ApplicationHelper
    def remove_profile_photo? profile
        params[:controller] == "profiles" && params[:action] == "edit" && profile.picture.attached?
    end

    def if_empty_default_message data_value
        data_value || "Awaiting details"
    end
end
