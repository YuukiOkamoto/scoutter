class ChangeDatatypeUidOfAuthentications < ActiveRecord::Migration[5.2]
  def change
    change_column :authentications, :uid, :bigint
  end
end
