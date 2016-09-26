class RemovePrototypeFromLikes < ActiveRecord::Migration
  def change
    remove_column :likes, :prototype_id, :integer
  end
end
