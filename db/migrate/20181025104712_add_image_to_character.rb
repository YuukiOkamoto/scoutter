class AddImageToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :image_path, :string, after: :maximum
  end
end
