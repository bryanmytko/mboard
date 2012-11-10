class Reply < ActiveRecord::Base
  belongs_to :topic
  serialize :likes
  attr_accessible :author, :comment, :topic_id, :image, :likes
  mount_uploader :image, ImageUploader
end
