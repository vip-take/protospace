class CreatePrototypes < ActiveRecord::Migration
  def change
    create_table :prototypes do |t|
    t.text :catchcopy
    t.text :concept
    t.integer :user_id
    t.string :title
    t.timestamps
    end
  end
end
