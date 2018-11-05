class RenameActionQualitiesIdColumnToActionPoints < ActiveRecord::Migration[5.2]
  def change
    rename_column :action_points, :action_qualities_id, :action_quality_id
  end
end
