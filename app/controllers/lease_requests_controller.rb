class LeaseRequestsController < ApplicationController
    before_action :authenticate_user!

    before_action :set_lease_request, only: [:show]
    before_action :set_lease_request_for_requester, only: [:edit, :update, :destroy]
    before_action :set_lease_request_for_listing_owner, only: [:accept, :reject]

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
        @lease_request = LeaseRequest.new(lease_request_params_for :create, profile_id: current_user.profile.id)

        if @lease_request.save
            redirect_to lease_request_path(@lease_request), "Lease request created successfully."
        else
            render :new
        end
    end

    # GET /leas_requests/:id/edit
    def edit
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
        @lease_request.status = :accepted
        if @lease_request.save
            render lease_request_path(@lease_request), "Lease request accepted."
        else
            render lease_request_path(@lease_request), "Can not accept lease request due to application error."
        end
    end

    # PATCH /leas_requests/:id/reject
    def reject
        @lease_request.status = :rejected
        if @lease_request.save
            render lease_request_path(@lease_request), "Lease request accepted."
        else
            render lease_request_path(@lease_request), "Can not accept lease request due to application error."
        end
    end

    # DELETE /leas_requests/:id
    def destroy
        @lease_request.status = :cancelled
        if @lease_request.save
            render lease_request_path(@lease_request), "Lease request cancelled."
        else
            render lease_request_path(@lease_request), "Can not cancel lease request due to application error."
        end
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
end