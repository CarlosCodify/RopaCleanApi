class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :code
      t.references :person, null: false, foreign_key: true

      t.timestamps
    end
  end
end
