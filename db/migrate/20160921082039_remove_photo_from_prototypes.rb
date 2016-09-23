class RemovePhotoFromPrototypes < ActiveRecord::Migration
  def change
    remove_column :prototypes, :photo, :string
  end
end
