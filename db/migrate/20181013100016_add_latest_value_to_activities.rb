class AddLatestValueToActivities < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :latest_value, :integer
  end
end
