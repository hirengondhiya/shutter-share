class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :title
      t.string :brand
      t.string :model
      t.text :description
      t.integer :rate
      t.integer :category, :default => 0
      t.integer :status, :default => 1
      t.references :profile, foreign_key: true

      t.timestamps
    end
  end
end
