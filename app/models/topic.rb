class Topic < ActiveRecord::Base
  has_many :reply
  has_one :topic_counter
  attr_accessible :title, :view_count, :slug, :creator
  validates :title, :uniqueness => { :case_sensitive => false }, :length => 1..50
end
