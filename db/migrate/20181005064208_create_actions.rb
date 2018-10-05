class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.string :action
      t.integer :limit
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
