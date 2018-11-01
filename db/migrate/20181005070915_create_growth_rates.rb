class CreateGrowthRates < ActiveRecord::Migration[5.2]
  def change
    create_table :growth_rates do |t|
      t.bigint :minimum
      t.bigint :maximum
      t.float :growth_rate
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
