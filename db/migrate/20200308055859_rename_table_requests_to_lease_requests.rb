class RenameTableRequestsToLeaseRequests < ActiveRecord::Migration[5.2]
  def change
      rename_table :requests, :lease_requests
  end
end
