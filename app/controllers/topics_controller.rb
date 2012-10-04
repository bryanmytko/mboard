
class TopicsController < ApplicationController
  def new
    #dummy method to add some default categories.
    dummyTopics = [ 'Songs Reu Likes', 'Fun For Everyone', 'Animated Gifs', 'Miscellaneous' ]
    dummyTopics.each do |d|
      Topic.create(:title => d, :view_count => 0, :slug => d.gsub(/ /,'-'))
    end
  end
end
