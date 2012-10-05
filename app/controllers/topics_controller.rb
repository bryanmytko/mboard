
class TopicsController < ApplicationController
  def new
    #dummy method to add some default categories.
    dummyTopics = [ 'Songs Reu Likes', 'Fun For Everyone', 'Animated Gifs', 'Miscellaneous' ]
    dummyTopics.each do |d|
      Topic.create(:title => d, :view_count => 0, :slug => d.gsub(/ /,'-'))
    end
  end
  
  def create
    params[:topic][:slug] = params[:topic][:title].gsub(/ /,'-')
    params[:topic][:view_count] = 0
    @topic = Topic.new(params[:topic])
    if @topic.save
      flash[:notice] = 'Topic Created!'
    else
      flash[:error] = 'Topic Already Exists!'
    end
    redirect_to(root_url)
  end
end
