class AddCountToTopicCounter < ActiveRecord::Migration
  def change
    add_column :topic_counters, :count, :integer, :default => 0
  end
end
