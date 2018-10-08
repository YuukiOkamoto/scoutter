class DropGrowthRates < ActiveRecord::Migration[5.2]
  def change
    drop_table :growth_rates
  end
end
