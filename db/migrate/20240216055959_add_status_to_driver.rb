class AddStatusToDriver < ActiveRecord::Migration[7.0]
  def change
    add_column :drivers, :status, :boolean
  end
end
