class AddTotalPowerColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    change_table :users, bulk: true do |t|
      t.bigint :total_power
      t.integer :character_id, index: true
    end
  end
end
