class ChangeNameColumnToActions < ActiveRecord::Migration[5.2]
  def change
    remove_column :actions, :name, :string
    add_column :actions, :kind, :Integer
  end
end
