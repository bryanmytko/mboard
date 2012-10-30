
class RepliesController < ApplicationController
  def create
    params[:reply][:author] = current_user.username

    @topic = Topic.find( params[:id] )
    @reply = @topic.reply.build( params[:reply] )
    @topic.last_author = current_user.username
    @topic.update_attribute(:updated_at, Time.now)
    @topic.save
    
    #paginate replies so we know where to link mention to
    @replies = Kaminari.paginate_array( 
    Reply.find_all_by_topic_id( @topic.id ) 
    ).page( params[:page] ).per( ENV['reply_pagination_count'] )
    
    if @reply.save
      
      #if reply contains 1 or more @ style mentions
      if params[:reply][:comment] =~ /\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/i 
        
        @thread_link = 'topic/' + @topic.slug + '?page=' + @replies.num_pages.to_s + "##{@reply.id.to_s}"

        #create a temporary array to hold each mention
        mentions = Array.new 
        
        params[:reply][:comment].gsub( /\B(@[a-zA-Z0-9_-]*.)(\n|\s)??/i ) { |x|
          #format username
          x = x.gsub( '@','' ).strip.downcase.capitalize
          #push into temp array all the mentions in the reply, if they are valid username and unique
          mentions.push( x ) if User.find_by_username( x ) && ( !mentions.include? x )
        }
        
        #create a mention record for each mention
        mentions.each do |m|
          @mention = Mention.new(
            :username => m,
            :thread_link => @thread_link,
            :read => 0,
            :mentioned_by => current_user.username
          ) 
          @mention.save
        end
      end
      flash[:notice] = 'Comment posted!'
      redirect_to topic_path @topic.slug, :page => @replies.num_pages.to_s, :anchor => @reply.id.to_s
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
    ).page( params[:page] ).per( ENV['reply_pagination_count'] )
    
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
