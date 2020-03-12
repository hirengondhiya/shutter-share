class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.datetime :start_date
      t.datetime :end_date
      t.integer :duration
      t.integer :rate
      t.integer :total
      t.references :profile, foreign_key: true
      t.references :listing, foreign_key: true

      t.timestamps
    end
  end
end
