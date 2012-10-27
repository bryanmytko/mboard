class AddMentionedByToMention < ActiveRecord::Migration
  def change
    add_column :mentions, :mentioned_by, :string
  end
end
