class TopicCounter < ActiveRecord::Base
  belongs_to :topic
  attr_accessible :topic_id, :count
end
