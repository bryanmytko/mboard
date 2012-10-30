
class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def create
    @user = User.new( params[:user].downcase.capitalize )
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
  end
end
