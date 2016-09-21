class ChangeColumnPhotoToImage < ActiveRecord::Migration
  def change
      change_column :images, :photo, :string
  end
end
