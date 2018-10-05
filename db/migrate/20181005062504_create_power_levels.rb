class CreatePowerLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :power_levels do |t|
      t.references :user
      t.bigint :power
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
