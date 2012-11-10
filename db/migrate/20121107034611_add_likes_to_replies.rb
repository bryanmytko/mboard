class AddLikesToReplies < ActiveRecord::Migration
  def change
    add_column :replies, :likes, :text
  end
end
