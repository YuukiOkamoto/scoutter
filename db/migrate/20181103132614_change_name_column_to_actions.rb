class ChangeNameColumnToActions < ActiveRecord::Migration[5.2]
  def change
    change_column :actions, :name, :Integer
    rename_column :actions, :name, :kind
  end
end
