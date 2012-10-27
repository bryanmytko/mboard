
class RepliesController < ApplicationController
  def create
    params[:reply][:author] = current_user.username

    @topic = Topic.find( params[:id] )
       
    @reply = @topic.reply.build( params[:reply] )
    @topic.last_author = current_user.username
    @topic.save

    if @reply.save
      if params[:reply][:comment] =~ /\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/i
        mentions = Array.new
        params[:reply][:comment].gsub( /\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/i ) { |x|
          x.gsub!( '@','' ).strip!
          mentions.push( x ) if User.find_by_username( x ) && ( !mentions.include? x )
        }
        mentions.each do |m|
          thread_link = request.env["HTTP_REFERER"].gsub( root_url,'' )
          read = 0
          @mention = Mention.new(
            :username => m,
            :thread_link => thread_link,
            :read => read,
            :mentioned_by => current_user.username
          ) 
          @mention.save
        end
      end    
      flash[:notice] = 'Comment posted!'
      redirect_to( topic_path( @topic.slug ) )
    else
      flash[:notice] = 'Failed to post comment.'
      redirect_to( root_url )
    end
  end
  
  def index
  end
    
  def show
    @topic = Topic.find_by_slug( params[:slug] )
    @reply = Reply.new
    #pagination: turn array into paginate_arry to use with Kaminari
    @replies = Kaminari.paginate_array( 
    Reply.find_all_by_topic_id( @topic.id ) 
    ).page( params[:page] ).per(10)
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
