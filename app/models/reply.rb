class Reply < ActiveRecord::Base
  belongs_to :topic
  attr_accessible :author, :comment, :topic_id
end
