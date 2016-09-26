class ChangeColumnToPrototype < ActiveRecord::Migration
  def change
    change_column :prototypes, :likes_count, :string, default: 0
  end
end
