class LeaseRequestsController < ApplicationController
    before_action :authenticate_user!

    before_action :set_lease_request, only: [:show]
    before_action :set_lease_request_for_requester, only: [:edit, :update, :destroy]
    before_action :set_lease_request_for_listing_owner, only: [:accept, :reject]

    before_action :verify_listing, only: [:new]
    before_action :redirect_if_lease_request_not_found, except: [:new, :create, :sent, :received]

    # GET /leas_requests/:id
    def show
    end

    # GET /leas_requests/new/:listing_id
    def new        
        @lease_request = LeaseRequest.new(listing_id: params[:listing_id], profile_id: current_user.profile.id)
    end

    # POST /leas_requests
    def create
        @lease_request = LeaseRequest.new(lease_request_params_for(:create))
        @lease_request.profile_id = current_user.profile.id

        if @lease_request.save
            redirect_to lease_request_path(@lease_request), notice: "Lease request created successfully."
        else
            render :new
        end
    end

    # GET /leas_requests/:id/edit
    def edit
        if @lease_request.status != "pending"
            redirect_to lease_request_path(@lease_request), alert: "Can not edit #{@lease_request.status} lease request."
        end
    end

    # PUT/PATCH /leas_requests/:id
    def update
        if @lease_request.update(lease_request_params_for :update)
            redirect_to edit_lease_request_path(@lease_request), notice: 'Lease request was successfully updated.'
        else
            render 'edit'
        end          
    end

    # PATCH /leas_requests/:id/accept
    def accept
        set_lease_request_status "accepted"
    end

    # PATCH /leas_requests/:id/reject
    def reject
        set_lease_request_status "rejected"
    end

    # DELETE /leas_requests/:id
    def destroy
        set_lease_request_status "cancelled"
    end

    # GET /leas_requests/sent
    def sent
        @lease_reqeusts = current_user.profile.lease_requests
    end

    # GET /leas_requests/received
    def received
        @lease_requests = current_user.profile.lease_requests_received
    end

    private
    # To make sure lease request can be viewed only by requester or creter of the listing
    def set_lease_request
        set_lease_request_for_requester
        if @lease_request == nil
            set_lease_request_for_listing_owner
        end
    end

    # To find lease request belonging to a listing created by current user
    def set_lease_request_for_listing_owner
        @lease_request = current_user.profile.lease_requests_received.find_by(id: params[:id])
    end

    # To find lease request sent by current user
    def set_lease_request_for_requester
        @lease_request = current_user.profile.lease_requests.find_by(id: params[:id])
    end

    # Redirect to home page for show, edit, update, destroy, accept, reject actions when lease request not found
    def redirect_if_lease_request_not_found
        if @lease_request == nil
            redirect_to root_path, alert: "Can not find the lease request."
        end
    end

    # To make sure listing id is not updated when user is updating the lease request
    def permit_params_for method_name
        {
            start_date: [:create, :update],
            end_date: [:create, :update],            
            listing_id: [:create]
        }.select { |param, methods| methods.include?(method_name)}.keys
    end

    # Only allow params based on the method name
    def lease_request_params_for method_name
        params.require(:lease_request).permit(permit_params_for method_name)
    end

    # def lease_request_params
    #     params.require(:lease_request).permit(:start_date, :end_date)
    # end

    def render_show_with_msg flash_type, flash_msg
        flash.now[flash_type] = flash_msg
        render :show
    end

    def set_lease_request_status status
        messages = {
            "cancelled": "cancel",
            "accepted": "accept",
            "rejected": "reject"
        }
        @lease_request.status = status
        if @lease_request.save
            render_show_with_msg :notice, "Lease request  was #{status} successfully."
        else
            render_show_with_msg :alert, "Can not #{messages[status]} lease request due to application error."
        end
    end

    def verify_listing
        listing = nil
        begin
            listing = Listing.find(params[:listing_id])
        rescue => exception
            puts "Listing with id '#{params[:listing_id]}' not found."
        ensure
            puts "in ensure"
            if (listing == nil || listing.status == "deleted" || listing.owned_by?(current_user))
                redirect_to root_path, alert: "Can not make a lease request on non existent or your own listing."
            end
        end
    end
end