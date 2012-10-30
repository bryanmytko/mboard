class AddCreatorToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :creator, :string
  end
end
