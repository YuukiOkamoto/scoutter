class CreateSumPowers < ActiveRecord::Migration[5.2]
  def change
    create_table :sum_powers do |t|
      t.references :user
      t.bigint :power
      t.integer :period
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
