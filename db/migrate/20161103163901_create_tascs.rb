class CreateTascs < ActiveRecord::Migration[5.0]
  def change
    create_table :tascs do |t|
    	t.string 	:task_name
    	t.text		:text
    	t.integer	:user_id, default: 0, null: false
      t.timestamps
    end
  end
end
