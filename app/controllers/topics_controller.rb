
class TopicsController < ApplicationController

  def create
    params[:topic][:creator] = User.find(session[:user_id]).username
    if params[:topic][:creator].nil?
      params[:topic][:creator] = '-'
    end
    params[:topic][:slug] = params[:topic][:title].gsub(/ /,'-')
    params[:topic][:view_count] = 0
    @topic = Topic.new( params[:topic] )
    @counter = @topic.build_topic_counter( :topic_id => params[:topic][:id] )
    if @topic.save
      flash[:notice] = 'Topic Created!'
      redirect_to( topic_path( @topic.slug ) )
    else
      flash[:error] = 'Topic Already Exists!'
      redirect_to( root_url )
    end
  end
  
  def destroy
    @topic = Topic.find_by_id( params[:id] )
    if @topic.destroy
      flash[:notice] = 'Thread deleted!'
       redirect_to( root_url )
    else
      flash[:notice] = 'Could not delete thread...'
       redirect_to( root_url )
    end
  end
end
