class AddPersonToUser < ActiveRecord::Migration[7.0]
  def change
    add_reference :people, :user, null: true, foreign_key: true
  end
end
