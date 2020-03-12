class CreateRequestStatuses < ActiveRecord::Migration[5.2]
  def change
    create_table :request_statuses do |t|
      t.integer :rstatus
      t.references :request, foreign_key: true

      t.timestamps
    end
  end
end
