require 'digest/md5'
require 'assets/notifications' #lib/notifications.rb
require 'assets/html_parse' #lib/assets/html_parse.rb

class ApplicationController < ActionController::Base
  protect_from_forgery
  
  ENV['reply_pagination_count'] = "25"

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
    admin_status.is_admin #boolean
  end
  helper_method :is_admin
  alias is_admin? is_admin
  
  def is_user_admin( author )
    return false if author.nil?
    admin_status = User.find_by_username( author.downcase.capitalize )
    admin_status.is_admin #boolean
  end
  helper_method :is_user_admin
  alias is_user_admin? is_user_admin
  
  def is_user
    session[:user_id].nil? ? false : true
  end
  helper_method :is_user
  alias is_user? is_user 
  
  def gravatar_self
    user = User.find_by_id( session[:user_id] )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_self
  
  def gravatar_user( author )
    user = User.find_by_username( author.downcase.capitalize )
    gravatar = Digest::MD5.hexdigest( user.email.downcase )
  end
  helper_method :gravatar_user
  
  def html_parse( string ) 
    HtmlParser::reply_parse( string )
  end 
  helper_method :html_parse

  def mention_count
    mentions = Mention.find_all_by_username( current_user.username )
    mentions.length
  end
  helper_method :mention_count
  
end
