class DropTableRequestStatuses < ActiveRecord::Migration[5.2]
  def change
    drop_table :request_statuses
  end
end
