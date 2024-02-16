class AddRoleToPerson < ActiveRecord::Migration[7.0]
  def change
    add_column :people, :role, :string
  end
end
