class AddLastAuthorToTopics < ActiveRecord::Migration
  def change
    add_column :topics, :last_author, :string
  end
end
