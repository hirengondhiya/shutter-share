class Lease_RequestsController < ApplicationController
    before_action :authenticate_user!

    private
    def set_lease_request
        @lease_request = Lease_Request
    end
end