class AddUnitPriceToClothingType < ActiveRecord::Migration[7.0]
  def change
    add_column :clothing_types, :unit_price, :decimal
  end
end
