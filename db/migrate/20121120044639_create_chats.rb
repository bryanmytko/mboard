class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.string :text
      t.string :username

      t.timestamps
    end
  end
end
