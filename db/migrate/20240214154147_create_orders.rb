class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :pickup_address, null: false, foreign_key: { to_table: :addresses }
      t.references :delivery_address, null: false, foreign_key: { to_table: :addresses }
      t.datetime :scheduled_date_time
      t.datetime :pickup_date_time
      t.datetime :delivery_date_time
      t.decimal :total_amount
      t.string :notes
      t.references :driver, null: false, foreign_key: true
      t.references :order_status, null: false, foreign_key: true
      t.references :payment_status, null: false, foreign_key: true

      t.timestamps
    end
  end
end
