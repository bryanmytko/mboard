class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :title
      t.string :slug
      t.integer :view_count
      t.timestamps
    end
  end
end
