require 'digest/md5'
class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  
  def current_user
    @current_user ||= User.find( session[:user_id] ) if session[:user_id]
  end
  helper_method :current_user
  
  def authorize
    redirect_to login_url if current_user.nil?
  end
  
  def gravatar_self
    user = User.find_by_id( session[:user_id] )
    gravatar = Digest::MD5.hexdigest( user.email )
  end
  helper_method :gravatar_self
  
  def gravatar_user( author )
    user = User.find_by_username( author )
    gravatar = Digest::MD5.hexdigest( user.email )
  end
  helper_method :gravatar_user
end
