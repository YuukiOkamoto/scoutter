class CreateCharacters < ActiveRecord::Migration[5.2]
  def change
    create_table :characters do |t|
      t.string :name
      t.text :introduction
      t.bigint :minimum
      t.bigint :maximum
      t.timestamps
      t.datetime :deleted_at

      t.index :deleted_at
    end
  end
end
