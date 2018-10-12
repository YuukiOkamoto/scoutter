class RemoveTotalPowerFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :total_power, :integer
  end
end
