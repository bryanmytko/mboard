class CreateReplies < ActiveRecord::Migration
  def change
    create_table :replies do |t|
      t.string :author
      t.text :comment
      t.integer :topic_id
      t.timestamps
    end
  end
end
