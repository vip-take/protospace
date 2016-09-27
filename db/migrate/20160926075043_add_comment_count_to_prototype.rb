class AddCommentCountToPrototype < ActiveRecord::Migration
  def change
    add_column :prototypes, :comments_count, :integer
  end
end
