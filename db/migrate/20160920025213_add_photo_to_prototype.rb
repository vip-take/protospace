class AddPhotoToPrototype < ActiveRecord::Migration
  def change
    add_column :prototypes, :photo, :string
  end
end
