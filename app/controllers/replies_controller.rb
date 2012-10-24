
class RepliesController < ApplicationController
  def create
    params[:reply][:author] = current_user.username

    @topic = Topic.find( params[:id] )
       
    @reply = @topic.reply.build( params[:reply] )
    @topic.last_author = current_user.username
    @topic.save

    if @reply.save
      flash[:notice] = 'Comment posted!'
      redirect_to( topic_path( @topic.slug ) )
    else
      flash[:notice] = 'Failed to post comment.'
      redirect_to( root_url )
    end
  end
    
  def show
    @topic = Topic.find_by_slug( params[:slug] )
    @reply = Reply.new
    @replies = Reply.find_all_by_topic_id( @topic.id )
    @counter = @topic.topic_counter
    @counter.count += 1
    @counter.save
  end
  
  def destroy
    @reply = Reply.find_by_id( params[:id] )
    @topic = Topic.find_by_id( @reply.topic_id )
    if @reply.destroy
      flash[:notice] = 'Comment deleted!'
       redirect_to( topic_path( @topic.slug ) )
    else
      flash[:notice] = 'Could not delete comment...'
       redirect_to( topic_path( @topic.slug ) )
    end
  end

end
