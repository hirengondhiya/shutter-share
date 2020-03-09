class AddStatusToLeaseRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :lease_requests, :status, :integer
  end
end
