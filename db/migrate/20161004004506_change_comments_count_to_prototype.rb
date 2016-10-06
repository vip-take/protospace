class ChangeCommentsCountToPrototype < ActiveRecord::Migration
  def change
    change_column :prototypes, :comments_count, :integer, default: 0
  end
end
