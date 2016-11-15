class AddAdminColumsToUsers < ActiveRecord::Migration[5.0]
  def change
  	add_column :users,  :admin, :integer, default: 0, null: false
  end
end
