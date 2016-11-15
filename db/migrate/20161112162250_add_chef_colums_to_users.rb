class AddChefColumsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users,  :chef, :integer, default: 0, null: false
  end
end
