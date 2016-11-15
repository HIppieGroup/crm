class AddGroupColumnsToTascs < ActiveRecord::Migration[5.0]
  def change
  	add_column :tascs, :group_id, :integer, default: 0, null: false
  end
end
