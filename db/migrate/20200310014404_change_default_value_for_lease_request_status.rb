class ChangeDefaultValueForLeaseRequestStatus < ActiveRecord::Migration[5.2]
  def change
    change_column_default :lease_requests, :status, 0
  end
end
