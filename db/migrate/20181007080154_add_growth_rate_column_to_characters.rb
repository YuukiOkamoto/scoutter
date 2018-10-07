class AddGrowthRateColumnToCharacters < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :growth_rate, :float
  end
end
