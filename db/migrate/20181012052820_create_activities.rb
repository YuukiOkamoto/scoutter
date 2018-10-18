class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.references :user
      t.references :action
      t.integer :yesterday_value

      t.timestamps
    end
  end
end
