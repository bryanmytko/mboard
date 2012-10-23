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
  
  def is_admin
    return false if session[:user_id].nil?
    admin_status = User.find_by_id( session[:user_id] )
    admin_status.is_admin
  end
  helper_method :is_admin
  
  def is_user_admin( author )
    return false if author.nil?
    admin_status = User.find_by_username( author )
    admin_status.is_admin
  end
  helper_method :is_user_admin
  
  def is_user
    return false if session[:user_id].nil?
    true
  end
  helper_method :is_user
  
  def gravatar_self
    user = User.find_by_id( session[:user_id] )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_self
  
  def gravatar_user( author )
    user = User.find_by_username( author )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_user
end
