class CreateMentions < ActiveRecord::Migration
  def change
    create_table :mentions do |t|
      t.string :username
      t.string :thread_link
      t.boolean :read

      t.timestamps
    end
  end
end
