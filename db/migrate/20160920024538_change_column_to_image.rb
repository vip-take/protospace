class ChangeColumnToImage < ActiveRecord::Migration
  def change
  def up
    change_column :images, :photo, :string
  end

  # 変更前の状態
  def down
    change_column :images, :photo, :text
  end

  end
end
