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

    def get_class_for status_name, type
        {
            cancelled: {
                icon: "fa fa-exclamation-circle",
                color: "text-muted"
            },
            rejected: {
                icon: "fa fa-thumbs-down",
                color: "text-danger"
            },
            pending: {
                icon: "fa fa-hourglass-1",
                color: "text-info"
            },
            expired: {
                icon: "fa fa-hourglass-3",
                color: "text-warning"
            },
            accepted: {
                icon: "fa fa-thumbs-up",
                color: "text-success"
            }
        }[status_name.to_sym][type]
    end

    def dollar_pd num
        "$#{num} per day"
    end

    def in_days num
        "#{num} day#{num.to_i > 1? 's': ''}"
    end

    def prefix_s num
        "$#{num}"
    end

    def date_in_au_form date
        date.in_time_zone("Sydney").strftime("%d/%m/%Y")
    end

    def current_user_profile_updated?
        current_user && current_user.profile && current_user.profile.name
    end
end
