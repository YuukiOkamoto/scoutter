class CreateActionPoints < ActiveRecord::Migration[5.2]
  def change
    create_table :action_points do |t|
      t.integer :point
      t.references :action_qualities
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
