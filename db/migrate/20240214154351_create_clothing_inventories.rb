class CreateClothingInventories < ActiveRecord::Migration[7.0]
  def change
    create_table :clothing_inventories do |t|
      t.integer :quantity
      t.references :clothing_type, null: false, foreign_key: true
      t.references :order, null: false, foreign_key: true

      t.timestamps
    end
  end
end
