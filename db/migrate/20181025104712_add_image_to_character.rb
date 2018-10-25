class AddImageToCharacter < ActiveRecord::Migration[5.2]
  def change
    add_column :characters, :image, :string, after: :maximum
  end
end
