class CreateTopicCounters < ActiveRecord::Migration
  def change
    create_table :topic_counters do |t|
      t.integer :topic_id, :default => 0
      t.timestamps
    end
  end
end
