
class RepliesController < ApplicationController
  def create
    params[:reply][:author] = current_user.username

    @topic = Topic.find(params[:id])
       
    @reply = @topic.reply.build(params[:reply])
    @topic.last_author = current_user.username
    @topic.save

    if @reply.save
      flash[:notice] = 'Comment posted!'
      redirect_to(topic_path(@topic.slug))
    else
      flash[:notice] = 'Failed to post comment.'
      redirect_to(root_url)
    end
  end
    
  def show
    @topic = Topic.find_by_slug(params[:slug])
    @reply = Reply.new
    @replies = Reply.find_all_by_topic_id(@topic.id)
    @topic.view_count += 1
    @topic.save
  end

end
