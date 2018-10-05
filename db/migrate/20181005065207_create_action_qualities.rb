class CreateActionQualities < ActiveRecord::Migration[5.2]
  def change
    create_table :action_qualities do |t|
      t.references :action
      t.integer :minimum
      t.integer :maximum
      t.integer :quality
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
