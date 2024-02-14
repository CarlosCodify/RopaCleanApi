class CreateMotorcycles < ActiveRecord::Migration[7.0]
  def change
    create_table :motorcycles do |t|
      t.boolean :status
      t.string :license_plate
      t.references :model, null: false, foreign_key: true

      t.timestamps
    end
  end
end
