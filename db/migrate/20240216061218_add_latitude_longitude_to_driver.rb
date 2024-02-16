class AddLatitudeLongitudeToDriver < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :latitude, :string
    add_column :drivers, :longitude, :string
  end
end
