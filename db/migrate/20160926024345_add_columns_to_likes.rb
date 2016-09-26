class AddColumnsToLikes < ActiveRecord::Migration
  def change
    add_reference :likes, :user, index: true
    add_reference :likes, :prototype, index: true
  end
end
