class Reply < ActiveRecord::Base
  belongs_to :topic
  attr_accessible :author, :comment, :topic_id, :image
  mount_uploader :image, ImageUploader
end
