
class SessionController < ApplicationController
  def new
  end
  
  def show
  end
  
  def create
    user = User.find_by_email( params[:email] )
    if user && user.authenticate( params[:password] )
      session[:user_id] =  user.id
      redirect_to root_url, notice: "Welcome, " + user.username
    else
      flash.now.alert = "Invalid email/password"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
