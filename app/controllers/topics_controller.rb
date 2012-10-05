
class TopicsController < ApplicationController

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
