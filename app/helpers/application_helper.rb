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

    def status_icon status
        case status
        when "cancelled"
            "fa fa-exclamation-circle"
        when "rejected"
            "fa fa-thumbs-down text-green"
        when "pending"
            "fa fa-hourglass-1"
        when "accepted"
            "fa fa-thumbs-up text-green"
        else
            ""
        end
    end
end
