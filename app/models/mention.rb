class Mention < ActiveRecord::Base
  attr_accessible :read, :thread_link, :username, :mentioned_by
end
