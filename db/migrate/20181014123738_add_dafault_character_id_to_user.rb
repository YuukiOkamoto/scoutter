class AddDafaultCharacterIdToUser < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :character_id, :integer, default: 1
  end
end
