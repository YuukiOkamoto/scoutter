class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :twitter_id
      t.timestamps
      t.datetime :deleted_at

      t.index :name
      t.index :deleted_at
    end
  end
end
