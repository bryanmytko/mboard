
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    params[:user][:username] = params[:user][:username].downcase.capitalize
    formatted_username = params[:user]
    @user = User.new( formatted_username )
    if @user.save
      flash[:notice] = 'Signed up!'
      redirect_to( root_url )
    else 
      render "new"
    end
  end
  
  def show
    @user = User.find_by_username( params[:author] )
    @replies = Reply.find_all_by_author( params[:author] )
    @recent_image = Reply.find_by_author( params[:author], :conditions => "image IS NOT NULL" )
    @recent_posts = Reply.find_all_by_author( params[:author], :limit => 5, :order => 'created_at DESC' )#, :conditions => "comment <> ''" )
  end
end
