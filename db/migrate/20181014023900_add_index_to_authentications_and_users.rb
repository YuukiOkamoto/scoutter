class AddIndexToAuthenticationsAndUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :authentications, :user_id
    add_index :users, :character_id
  end
end
