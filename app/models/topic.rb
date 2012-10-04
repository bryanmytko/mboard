class Topic < ActiveRecord::Base
  has_many :reply
  attr_accessible :title, :view_count, :slug
end
