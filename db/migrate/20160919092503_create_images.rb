class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.integer :prototype_id
      t.text :photo
      t.integer :role
      t.timestamps
    end
  end
end
